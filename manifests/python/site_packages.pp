# Class: openstack-hyper-v::python::site_packages
#
# This module copies the contents of %TEMP%\PLATLIB\* to c:\Python27\Lib\site-packages
#
# Parameters: none
#
# Actions:
#
class openstack-hyper-v::python::site_packages {

  $platlib = "${::temp}\\PLATLIB"

# Classes extracting installers to %TEMP%\PLATLIB
  require openstack-hyper-v::python::mysql_python
  require openstack-hyper-v::python::pycrypto
  require openstack-hyper-v::python::pywin32
  require openstack-hyper-v::python::greenlet
  require openstack-hyper-v::python::lxml

  Class['openstack-hyper-v::python::pywin32']      ->
  Class['openstack-hyper-v::python::pycrypto']     ->
  Class['openstack-hyper-v::python::mysql_python'] ->
  Class['openstack-hyper-v::python::lxml']         ->
  Class['openstack-hyper-v::python::greenlet']
#  Exec['xcopy_PLATLIB']

#    exec { 'xcopy_PLATLIB':
#        command   => "xcopy.exe ${::tmp}\\PLATLIB\\* c:\Python27\Lib\site-packages\",
#        require   => Class ['openstack-hyper-v::python', 'openstack-hyper-v::python::easyinstall'],
#    }

}

