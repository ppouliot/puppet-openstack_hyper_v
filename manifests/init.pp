# === Class: openstack_hyper_v
#
# This module contains basic configuration tasks for building openstack_hyper_v
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
# [*purge_nova_config*]
#   Specifies if the nova_config file will only have values configured with
#   puppet.
#
# == Examples
#
#  class { 'openstack_hyper_v':
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
class openstack_hyper_v (
  # Live Migration
  $live_migration            = false,
  $live_migration_type       = 'Kerberos',
  $live_migration_networks   = undef,
  # Virtual Switch
  $virtual_switch_name       = 'br100',
  $virtual_switch_address    = $::ipaddress,
  $virtual_switch_os_managed = true,
  # Others
  $purge_nova_config         = true,
){

  class { 'openstack_hyper_v::base::hyper_v': }

  class { 'openstack_hyper_v::base::live_migration':
    enable              => $live_migration,
    authentication_type => $live_migration_type,
    allowed_networks    => $live_migration_networks,
    require             => Class['openstack_hyper_v::base::hyper_v'],
  }

  virtual_switch { $virtual_switch_name:
    notes             => 'OpenStack Compute Virtual Switch',
    interface_address => $virtual_switch_address,
    type              => External,
    os_managed        => $virtual_switch_os_managed,
    require           => Class['openstack_hyper_v::base::hyper_v'],
  }  

  if ! defined( Resources[nova_config] ) {
    if $purge_nova_config {
      resources { 'nova_config':
        purge => true,
      }
    }
  }

  nova_config {
    'DEFAULT/compute_driver': value => 'nova.virt.hyperv.driver.HyperVDriver';
  }


  class { 'openstack_hyper_v::base::ntp': }
  class { 'openstack_hyper_v::base::disable_firewalls': }
  class { 'openstack_hyper_v::base::enable_auto_update': }
  class { 'openstack_hyper_v::base::rdp': }

  # Tools
  #class { 'openstack_hyper_v::tools::vexasoftcmdlet': }
  #class { 'openstack_hyper_v::tools::git': }

  # Optional
  #class { 'openstack_hyper_v::java': }
  #class { 'openstack_hyper_v::tools::notepadplusplus': }
  #class { 'openstack_hyper_v::tools::google_chrome': }
  #class {' openstack_hyper_v::tools::visualcplusplus2010': }
  #class { 'openstack_hyper_v::tools::visualcplusplus2012': }
  #class { 'openstack_hyper_v::tools::freerdp': }

  class { 'openstack_hyper_v::nova_dependencies': }
   
  #class { 'openstack_hyper_v::openstack::folders':}

}
