#!c:\Python27\python.exe
# vim: tabstop=4 shiftwidth=4 softtabstop=4

# Copyright 2010 United States Government as represented by the
# Administrator of the National Aeronautics and Space Administration.
# All Rights Reserved.
#
#    Licensed under the Apache License, Version 2.0 (the "License"); you may
#    not use this file except in compliance with the License. You may obtain
#    a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#    License for the specific language governing permissions and limitations
#    under the License.

"""Starter script for Nova Compute."""

import eventlet
import os
import sys

if os.name == 'nt':
    # eventlet monkey patching causes subprocess.Popen to fail on Windows
    # when using pipes due to missing non blocking I/O support
    eventlet.monkey_patch(os=False)
    import win32service
    import win32serviceutil
    import time
    # using the service launcher messes up the dir tree so do this
    NOVAPATH = sys.path[0]
    NOVAPATH = NOVAPATH[:-3]
    sys.path.insert(0, NOVAPATH)
else:
    eventlet.monkey_patch()

import os
import sys
import traceback

from oslo.config import cfg

# If ../nova/__init__.py exists, add ../ to Python search path, so that
# it will override what happens to be installed in /usr/(local/)lib/python...
POSSIBLE_TOPDIR = os.path.normpath(os.path.join(os.path.abspath(sys.argv[0]),
                                   os.pardir,
                                   os.pardir))
if os.path.exists(os.path.join(POSSIBLE_TOPDIR, 'nova', '__init__.py')):
    sys.path.insert(0, POSSIBLE_TOPDIR)


from nova import config
import nova.db.api
from nova import exception
from nova.openstack.common import log as logging
from nova import service
from nova import utils

CONF = cfg.CONF
CONF.import_opt('compute_topic', 'nova.compute.rpcapi')
CONF.import_opt('use_local', 'nova.conductor.api', group='conductor')
LOG = logging.getLogger('nova.compute')


def block_db_access():
    class NoDB(object):
        def __getattr__(self, attr):
            return self

        def __call__(self, *args, **kwargs):
            stacktrace = "".join(traceback.format_stack())
            LOG.error('No db access allowed in nova-compute: %s' % stacktrace)
            raise exception.DBNotAllowed('nova-compute')

    nova.db.api.IMPL = NoDB()

class NovaComputeWindowsService(win32serviceutil.ServiceFramework):
    _svc_name_ = "nova-compute"
    _svc_display_name_ = "nova-compute"
    _svc_description_ = "OpenStack Nova compute service for Hyper-V"

    def __init__(self,args):
        win32serviceutil.ServiceFramework.__init__(self,args)
        config.parse_args(sys.argv)
        logging.setup('nova')
        utils.monkey_patch()

        if not CONF.conductor.use_local:
            block_db_access()
        self.isAlive = True

    def SvcDoRun(self):
        import servicemanager

        servicemanager.LogInfoMsg("OpenStack Compute: Starting")

        server = service.Service.create(binary='nova-compute',
                                        topic=CONF.compute_topic,
                                        db_allowed=False)
        service.serve(server)

        while self.isAlive :
            time.sleep(5)
    
        servicemanager.LogInfoMsg("OpenStack Compute: Stopped")

    def SvcStop(self):
        import servicemanager
    
        servicemanager.LogInfoMsg("OpenStack Compute: Recieved stop signal")
        self.ReportServiceStatus(win32service.SERVICE_STOP_PENDING)
        self.isAlive = False

if __name__ == '__main__':
    win32serviceutil.HandleCommandLine(NovaComputeWindowsService)

