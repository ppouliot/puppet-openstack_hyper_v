# Class: windows::nova_deps
#
# This installs pip installable nova dependencies on windows
#
# Parameters: none
#
# Actions:
#
class windows::nova_deps{

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

  exec { 'install_nova_deps':
    path    => $::winpath,
    command => 'C:\Python27\Scripts\pip.exe install eventlet iso8601 webob netaddr paste pastedeploy routes wmi sqlalchemy sqlalchemy-migrate kombu',
#   require => Class['windows::python', 'windows::git', 'windows::pip', 'windows::pywin32', 'windows::greenlet', 'windows::python-m2crypto', 'windows::python-mysql', 'windows::easyinstall', 'windows::lxml'],
  }

}
