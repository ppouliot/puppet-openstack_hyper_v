# Class: openstack_hyper_v::python::nova_depends
#
# This installs pip installable nova dependencies on windows
#
# Parameters: none
#
# Actions:
#
class openstack_hyper_v::python::nova_depends {

  exec { 'install_nova_deps':
    path    => $::path,
    command => 'C:\Python27\Scripts\pip.exe install eventlet iso8601 webob netaddr paste pastedeploy routes wmi sqlalchemy sqlalchemy-migrate kombu',
#   require => Class['openstack_hyper_v::python', 'openstack_hyper_v::git', 'openstack_hyper_v::pip', 'openstack_hyper_v::pywin32', 'openstack_hyper_v::greenlet', 'openstack_hyper_v::python-m2crypto', 'openstack_hyper_v::python-mysql', 'openstack_hyper_v::easyinstall', 'openstack_hyper_v::lxml'],
  }

}
