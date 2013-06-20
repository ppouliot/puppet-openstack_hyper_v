# === Class: openstack-hyper-v
#
# This module contains basic configuration tasks for building openstack-hyper-v
# compute nodes for openstack
#
# === Parameters
#
# [*live_migration*]
#   Specify if the compute node will have the live migration enabled
# [*live_migration_type*]
#   Authentication method used for migration: 'Kerberos' or 'CredSSP'
# [*live_migration_networks*]
#   Comma separated list of the networks allowed in live migration. If the
#   value is undef, any network will be allowed.
# [*virtual_switch_name*]
#   Name of the virtual switch to define in the hypervisor.
# [*virtual_switch_address*]
#   IP address of the physical adapter where the switch will be bound
# [*virtual_switch_os_managed*]
#   Specifies if the management OS is to have access to the physical adapter
#
# == Examples
#
#  class { 'openstack-hyper-v':
#    live_migration            => true,
#    live_migration_type       => 'Kerberos',
#    live_migration_networks   => '192.168.0.0/24',
#    virtual_switch_name       => 'br100',
#    virtual_switch_address    => '192.168.1.133',
#    virtual_switch_os_managed => true,
#  }
#
# == Authors
#
class openstack-hyper-v (
  # Live Migration
  $live_migration            = false,
  $live_migration_type       = 'Kerberos',
  $live_migration_networks   = undef,
  # Virtual Switch
  $virtual_switch_name       = 'br100',
  $virtual_switch_address    = $::ipaddress,
  $virtual_switch_os_managed = true,
){

  class { 'openstack-hyper-v::commands': }

  class { 'openstack-hyper-v::base::live_migration':
    enable              => $live_migration,
    authentication_type => $live_migration_type,
    allowed_networks    => $live_migration_networks,
  }

  virtual_switch { $virtual_switch_name:
    notes             => 'OpenStack Compute Virtual Switch',
    interface_address => $virtual_switch_address,
    type              => External,
    os_managed        => $virtual_switch_os_managed,
  }  

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
