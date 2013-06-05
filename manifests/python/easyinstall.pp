# Class: windows::easyinstall
#
# This module downloads then installs distribute_setup.py to intsall python setuptools
#
# Parameters: none
#
# Actions:
#

class windows::python::easyinstall{
  $ez_url = 'http://python-distribute.org/distribute_setup.py'
  $ez_file = 'distribute_setup.py'

  commands::download{ 'distribute_setup.py':
    url  => $ez_url,
    file => $ez_file,
  }

  exec { 'easy_install_distribute_setup':
    command   => "C:/Python27/python.exe ${::temp}/distribute_setup.py",
    cwd       => $::temp,
    require   => Class['windows::python', 'windows::python::pywin32','windows::python::mysql_python'],
  }
}
