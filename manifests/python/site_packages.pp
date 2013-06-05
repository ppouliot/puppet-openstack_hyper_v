# Class: windows::python::site_packages
#
# This module copies the contents of %TEMP%\PLATLIB\* to c:\Python27\Lib\site-packages
#
# Parameters: none
#
# Actions:
#
class windows::python::site_packages {

 $platlib = "${::temp}\\PLATLIB"

# Classes extracting installers to %TEMP%\PLATLIB
  require windows::python::mysql_python
  require windows::python::pycrypto
  require windows::python::pywin32
  require windows::python::greenlet
  require windows::python::lxml

  Class['windows::python::pywin32']      ->
  Class['windows::python::pycrypto']     ->
  Class['windows::python::mysql_python'] ->
  Class['windows::python::lxml']         ->
  Class['windows::python::greenlet']
#  Exec['xcopy_PLATLIB']

#    exec { 'xcopy_PLATLIB':
#        command   => "xcopy.exe ${::tmp}\\PLATLIB\\* c:\Python27\Lib\site-packages\",
#        require   => Class ['windows::python', 'windows::python::easyinstall'],
#    }

}

