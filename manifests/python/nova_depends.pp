# Class: openstack-hyper-v::python::nova_depends
#
# This installs pip installable nova dependencies on windows
#
# Parameters: none
#
# Actions:
#
class openstack-hyper-v::python::nova_depends {

  exec { 'install_nova_deps':
    path    => $::path,
    command => 'C:\Python27\Scripts\pip.exe install eventlet iso8601 webob netaddr paste pastedeploy routes wmi sqlalchemy sqlalchemy-migrate kombu',
#   require => Class['openstack-hyper-v::python', 'openstack-hyper-v::git', 'openstack-hyper-v::pip', 'openstack-hyper-v::pywin32', 'openstack-hyper-v::greenlet', 'openstack-hyper-v::python-m2crypto', 'openstack-hyper-v::python-mysql', 'openstack-hyper-v::easyinstall', 'openstack-hyper-v::lxml'],
  }

}
