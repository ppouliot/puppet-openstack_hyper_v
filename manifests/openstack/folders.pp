# Class: openstack_hyper_v::openstack::folders
#
# This creates the default folder layout for the running configuration of openstack
#
# Parameters: none
#
# Actions:
#
class openstack_hyper_v::openstack::folders {
  file { 'C:/OpenStack':
    ensure => directory,
  }

  file { 'C:/OpenStack/scripts': 
    ensure  => directory,
    require => File['C:/OpenStack'],
  }

  file { 'C:/OpenStack/etc':
    ensure  => directory,
    require => File['C:/OpenStack'],
  }

  file { 'C:/OpenStack/Log':
    ensure  => directory,
    require => File['C:/OpenStack'],
  }

  file { 'C:/OpenStack/instances':
    ensure  => directory,
    require => File['C:/OpenStack'],
  }
}
