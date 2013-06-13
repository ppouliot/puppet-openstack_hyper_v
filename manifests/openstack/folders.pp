# Class: openstack-hyper-v::openstack::folders
#
# This creates the default folder layout for the running configuration of openstack
#
# Parameters: none
#
# Actions:
#
class openstack-hyper-v::openstack::folders {

  file { 'c:\openstack':
    ensure => directory,
  }

  file { 'c:\openstack\log':
    ensure => directory,
  }

  file { 'c:\openstack\instances':
    ensure => directory,
  }

  file { 'c:\openstack\vhd':
    ensure => directory,
  }

  file { 'c:\openstack\scripts':
    ensure => directory,
  }
  file { 'c:\etc':
    ensure => directory,
  }

}
