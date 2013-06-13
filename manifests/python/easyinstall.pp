# Class: openstack-hyper-v::easyinstall
#
# This module downloads then installs distribute_setup.py to intsall python setuptools
#
# Parameters: none
#
# Actions:
#

class openstack-hyper-v::python::easyinstall{
  $ez_url = 'http://python-distribute.org/distribute_setup.py'
  $ez_file = 'distribute_setup.py'

  commands::download{ 'distribute_setup.py':
    url  => $ez_url,
    file => $ez_file,
  }

  exec { 'easy_install_distribute_setup':
    command   => "C:/Python27/python.exe ${::temp}/distribute_setup.py",
    cwd       => $::temp,
    require   => Class['openstack-hyper-v::python', 'openstack-hyper-v::python::pywin32','openstack-hyper-v::python::mysql_python'],
  }
}
