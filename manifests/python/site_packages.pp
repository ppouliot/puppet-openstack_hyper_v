# Class: openstack_hyper_v::python::site_packages
#
# This module copies the contents of %TEMP%\PLATLIB\* to c:\Python27\Lib\site-packages
#
# Parameters: none
#
# Actions:
#
class openstack_hyper_v::python::site_packages {

  $platlib = "${::temp}\\PLATLIB"

# Classes extracting installers to %TEMP%\PLATLIB
  require openstack_hyper_v::python::mysql_python
  require openstack_hyper_v::python::pycrypto
  require openstack_hyper_v::python::pywin32
  require openstack_hyper_v::python::greenlet
  require openstack_hyper_v::python::lxml

  Class['openstack_hyper_v::python::pywin32']      ->
  Class['openstack_hyper_v::python::pycrypto']     ->
  Class['openstack_hyper_v::python::mysql_python'] ->
  Class['openstack_hyper_v::python::lxml']         ->
  Class['openstack_hyper_v::python::greenlet']
#  Exec['xcopy_PLATLIB']

#    exec { 'xcopy_PLATLIB':
#        command   => "xcopy.exe ${::tmp}\\PLATLIB\\* c:\Python27\Lib\site-packages\",
#        require   => Class ['openstack_hyper_v::python', 'openstack_hyper_v::python::easyinstall'],
#    }

}

