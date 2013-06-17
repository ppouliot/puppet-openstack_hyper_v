# Class: openstack-hyper-v
#
# This module contains basic configuration tasks for
# building openstack-hyper-v compute nodes for openstack
#
# Parameters: none
#
# Actions:
#


class openstack-hyper-v (
  # Virtual switch
  $virtual_switch_name = 'br100',
  $virtual_switch_address = $::ipaddress,
  $virtual_switch_os_managed = true,
){
  $winpath         = "${::systemroot}\\sysnative;c:\\winpe\\bin;${::path}"
  $powershell_path = "${::systemroot}\\sysnative\\WindowsPowerShell\\v1.0"
  $path            = "${winpath};${powershell_path};${::path}"
  #Default Time Source and Zone
  #$timeserver = 'bonehed.lcs.mit.edu'
  #$timezone   = 'Eastern Standard Time'
  Exec{
    path => "${powershell_path};${winpath};${::path}",
  }

  class { 'openstack-hyper-v::base::virtual_switch':
    name              => $virtual_switch_name,
    notes             => 'OpenStack Compute Virtual Switch',
    interface_address => $virtual_switch_address,
    connection_type   => 'External',
    os_managed        => $virtual_switch_os_managed,
  }  

#  class { 'openstack-hyper-v::commands': }
  include quartermaster::commands
  class { 'openstack-hyper-v::base::ntp': }
  class { 'openstack-hyper-v::base::disable_firewalls': }
  class { 'openstack-hyper-v::base::enable_auto_update': }
  class { 'openstack-hyper-v::base::rdp': }

  # Tools
  class { 'openstack-hyper-v::tools::7zip': }
  class { 'openstack-hyper-v::tools::vexasoftcmdlet': }
  class { 'openstack-hyper-v::tools::git': }
  # Optional
  class { 'openstack-hyper-v::java': }
  class { 'openstack-hyper-v::tools::notepadplusplus': }
  class { 'openstack-hyper-v::tools::google_chrome': }
  #class {' openstack-hyper-v::tools::visualcplusplus2010': }
  #class { 'openstack-hyper-v::tools::visualcplusplus2012': }
  class { 'openstack-hyper-v::tools::freerdp': }
# Begin Python Stack
  class { 'openstack-hyper-v::python': }
  class { 'openstack-hyper-v::python::m2crypto': }
# Classes extracting installers to %TEMP%\PLATLIB
# -- Moving to site_packages.pp
#  class { 'openstack-hyper-v::python::mysql_python': }
#  class { 'openstack-hyper-v::python::pycrypto': }
#  class { 'openstack-hyper-v::python::pywin32': }
#  class { 'openstack-hyper-v::python::greenlet': }
#  class { 'openstack-hyper-v::python::lxml': }
  class { 'openstack-hyper-v::python::site_packages': }
  class { 'openstack-hyper-v::python::easyinstall': }
  class { 'openstack-hyper-v::python::pip': }
  class { 'openstack-hyper-v::openstack::folders':}

}
