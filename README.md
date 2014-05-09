OpenStack-Hyper-V (A module for building Windows/Hyper-V OpenStack Compute nodes)
=================================================================

This modules begins the configuration of a openstack_hyper_v compute node for openstack.

It currently has the beginings of both from package and from source options.

This is still a work in progress.

Basic usage
-----------

To configure openstack_hyper_v compute on a windows/hyper-v server

    class { 'openstack_hyper_v':
      # Rabbit
      rabbit_host               => 'rabbit',
      rabbit_password           => hiera('rabbit_password'),
      rabbit_userid             => 'nova',
      rabbit_virtual_host       => '/',
      # Glance
      glance_api_servers        => '192.168.0.120:9393',
      # Live Migration
      live_migration            => true,
      live_migration_type       => 'Kerberos',
      live_migration_networks   => '192.168.0.0/24',
      # Virtual Switch
      virtual_switch_name       => 'br100',
      virtual_switch_address    => inline_template("<%= require 'resolv'; Resolv.new.getaddress(@fqdn)%>"),
      virtual_switch_os_managed => true,
      # General
      instances_path            => 'D:\\',
      verbose                   => false,
      debug                     => false,
      nova_compute              => true,
      mkisofs_cmd               => 'H:\Shared\openstack\tools\mkisofs.exe',
      qemu_img_cmd              => 'H:\Shared\openstack\tools\qemu-img.exe';
    }


Contributors
------------

 * Peter Pouliot <peter@pouliot.net>
 * Octavian Ciuhandu <ociuhandu@cloudbasesolutions.com>
 * Luis Fernandez Alvarez <luis.fernandez.alvarez@cern.ch>
 * Vijay Tripathi <vijayt@microsoft.com>


Copyright and License
---------------------

Copyright (C) 2013 Peter J. Pouliot

Peter Pouliot can be contacted at: peter@pouliot.net

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
