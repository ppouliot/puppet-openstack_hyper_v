# === Class: openstack_hyper_v
#
# This module contains basic configuration tasks for building openstack_hyper_v
# compute nodes for openstack
#
# === Parameters
#
# [*nova_compute*]
#   Enable or not nova compute service. Defaults to true.
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
# [*nova_source*]
#   System path to egg distribution of nova
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
#    nova_source               => 'F:\Shared\Software\OpenStack\nova-2013.1.2-py2.7.egg'
#  }
#
# == Authors
#
class openstack_hyper_v (
  # Services
  $nova_compute              = true,
  # General
  $network_manager           = 'nova.network.manager.FlatDHCPManager',
  $rabbit_host,
  $rabbit_port,
  $rabbit_user,
  $rabbit_password,
  $rabbit_virtual_host       = '/',
  $glance_api_servers        = 'localhost:9393',
  $instances_path            = 'C:\OpenStack\instances',
  $mkisofs_cmd               = undef,
  $qemu_img_cmd              = undef,
  # Live Migration
  $live_migration            = false,
  $live_migration_type       = 'Kerberos',
  $live_migration_networks   = undef,
  # Virtual Switch
  $virtual_switch_name       = 'br100',
  $virtual_switch_address    = $::ipaddress,
  $virtual_switch_os_managed = true,
  # Others
  $nova_source,
  $purge_nova_config         = true,
  $verbose                   = false,
  $debug                     = false
){
  Class['openstack_hyper_v::openstack::folders'] -> Nova_config <| |>
  Nova_config<| |> -> File['C:/OpenStack/etc/nova.conf']
  Nova_config<| |> ~> Service['nova-compute']

  class { 'openstack_hyper_v::openstack::folders': }

  file { 'C:/OpenStack/etc/policy.json':
    ensure  => file,
    source  => "puppet:///modules/openstack_hyper_v/policy.json",
    require => Class['openstack_hyper_v::openstack::folders'],
  }

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

  file { 'C:/OpenStack/etc/nova.conf':
    ensure => file,
  }

  nova_config {
    # Network
    'DEFAULT/network_manager':                        value => $network_manager;
    # Rabbit
    'DEFAULT/rabbit_userid':                          value => $rabbit_user;
    'DEFAULT/rabbit_password':                        value => $rabbit_password;
    'DEFAULT/rabbit_virtual_host':                    value => $rabbit_virtual_host;
    'DEFAULT/rabbit_host':                            value => $rabbit_host;
    'DEFAULT/rabbit_port':                            value => $rabbit_port;
    # Glance
    'DEFAULT/image_service':                          value => 'nova.image.glance.GlanceImageService';
    'DEFAULT/glance_api_servers':                     value => $glance_api_servers;
    # General  
    'DEFAULT/logdir':                                 value => 'C:\OpenStack\Log';
    'DEFAULT/verbose':                                value => $verbose;
    'DEFAULT/debug':                                  value => $debug;
    'DEFAULT/auth_strategy':                          value => 'keystone';
    'DEFAULT/volume_api_class':                       value => 'nova.volume.cinder.API';
    'DEFAULT/rpc_backend':                            value => 'nova.openstack.common.rpc.impl_kombu';
    'DEFAULT/use_cow_images':                         value => 'true';
    'DEFAULT/force_config_drive':                     value => 'false';
    'DEFAULT/config_drive_inject_password':           value => 'false';
    'DEFAULT/policy_file':                            value => 'C:\OpenStack\etc\policy.json';
    'DEFAULT/allow_resize_to_same_host':              value => 'true';
    'DEFAULT/running_deleted_instance_action':        value => 'reap';
    'DEFAULT/running_deleted_instance_poll_interval': value => 120;
    'DEFAULT/resize_confirm_window':                  value => 5;
    # Hyper-V
    'DEFAULT/vswitch_name':                           value => $virtual_switch_name;
    'DEFAULT/instances_path':                         value => $instances_path;
    'DEFAULT/limit_cpu_features':                     value => 'false';
    'DEFAULT/mkisofs_cmd':                            value => $mkisofs_cmd;
    'DEFAULT/qemu_img_cmd':                           value => $qemu_img_cmd;
    'DEFAULT/compute_driver':                         value => 'nova.virt.hyperv.driver.HyperVDriver';
  }

  class { 'openstack_hyper_v::nova_dependencies':
    py_nova_source => $nova_source,
  }

  file { 'C:/OpenStack/scripts/NovaComputeWindowsService.py':
    ensure  => file,
    source  => "puppet:///modules/openstack_hyper_v/NovaComputeWindowsService.py",
    require => Class['openstack_hyper_v::openstack::folders'],
  }

  openstack_hyper_v::python::windows_service { 'nova-compute':
    description => 'OpenStack Nova compute service for Hyper-V',
    start       => auto,
    arguments   => '--config-file=C:\OpenStack\etc\nova.conf',
    script      => 'C:\OpenStack\scripts\NovaComputeWindowsService.NovaComputeWindowsService',
    require     => [File['C:/OpenStack/scripts/NovaComputeWindowsService.py'],
                    Class['openstack_hyper_v::base::hyper_v'],
                    Class['openstack_hyper_v::base::live_migration'],
                    Virtual_switch[$virtual_switch_name],
                    Class['openstack_hyper_v::nova_dependencies'],],
  }

  if $nova_compute {
    $service_state = 'running'
  }else{
    $service_state = 'stopped'
  }

  service { 'nova-compute':
    name       => 'nova-compute',
    ensure     => $service_state,
    enable     => true,
    hasrestart => true,
    require    => Openstack_hyper_v::Python::Windows_service['nova-compute'],
  }
}
