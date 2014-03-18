#
# == Class: openstack_hyper_v::compute
#
# Manifest to install/configure nova-compute
#
# [purge_nova_config]
#   Whether unmanaged nova.conf entries should be purged.
#   (optional) Defaults to false.
#
# [rabbit_hosts] An array of IP addresses or Virttual IP address for connecting to a RabbitMQ Cluster.
#   Optional. Defaults to false.
#
# === Examples
#
# class { 'openstack::compute':
#   internal_address   => '192.168.2.2',
#   vncproxy_host      => '192.168.1.1',
#   nova_user_password => 'changeme',
# }

class openstack_hyper_v::compute (
  # Required Network
  $internal_address,
  # Required Rabbit
  $rabbit_password,
  # Network
  $network_manager               = 'nova.network.manager.FlatDHCPManager',
  # Nova
  $purge_nova_config             = true,
  # Rabbit
  $rabbit_host                   = '127.0.0.1',
  $rabbit_hosts                  = false,
  $rabbit_user                   = 'openstack',
  $rabbit_virtual_host           = '/',
  # Glance
  $glance_api_servers            = false,
  # Virtualization
  $virtualization_driver         = 'hyperv',
  # Hyper-V
  $mkisofs_cmd                   = undef,
  $qemu_img_cmd                  = undef,
  $instances_path                = 'C:\OpenStack\instances',
  $virtual_switch_address        = $::ipaddress,
  $hyperv_service_user           = 'LocalSystem',
  $hyperv_service_pass           = '',
  # General
  $nova_repository               = "git+https://github.com/openstack/nova.git",
  $nova_version                  = "2013.1.4",
  $nova_source                   = false,
  $migration_support             = false,
  $verbose                       = false,
  $debug                         = false,
  $force_config_drive            = false,
  $enabled                       = true
) {
  #
  # indicates that all nova config entries that we did
  # not specifify in Puppet should be purged from file
  #
  if ! defined( Resources[hyperv_nova_config] ) {
    if ($purge_nova_config) {
      resources { 'hyperv_nova_config':
        purge => true,
      }
    }
  }

  class { 'nova_hyper_v':
    rabbit_userid         => $rabbit_user,
    rabbit_password       => $rabbit_password,
    image_service         => 'nova.image.glance.GlanceImageService',
    glance_api_servers    => $glance_api_servers,
    verbose               => $verbose,
    debug                 => $debug,
    rabbit_host           => $rabbit_host,
    rabbit_hosts          => $rabbit_hosts,
    rabbit_virtual_host   => $rabbit_virtual_host,
    rabbit_config_cluster => true,
    nova_repository       => $nova_repository,
    nova_version          => $nova_version,
    nova_source           => $nova_source,
  }

  # Install / configure nova-compute
  class { '::nova_hyper_v::compute':
    enabled             => $enabled,
    force_config_drive  => $force_config_drive,
    hyperv_service_user => $hyperv_service_user,          
    hyperv_service_pass => $hyperv_service_pass,
  }

  # Configure virtualization driver for nova-compute
  case $virtualization_driver {
    #'libvirt': {    
    #  class { 'nova_hyper_v::compute::libvirt':
    #    libvirt_type      => $libvirt_type,
    #    vncserver_listen  => $vncserver_listen_real,
    #    migration_support => $migration_support,
    #  }
    #}
    'hyperv': {
      class { 'nova_hyper_v::compute::hyperv':
        live_migration => $migration_support,
        instances_path => $instances_path, 
      }
    }
    default: {
       fail("Unsupported virtualization driver: $virtualization_driver, module ${module_name} only support drivers: hyperv")
    }
  }

  class { 'nova_hyper_v::network':
    network_manager   => $network_manager,
  }
}
