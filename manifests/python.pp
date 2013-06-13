# Class: openstack-hyper-v::python
#
# This module downloads then installs Python 2.7.3
#
# Parameters: none
#
# Actions:
#

class openstack-hyper-v::python {

  $py_url  = 'http://www.python.org/ftp/python/2.7.3'
  $py_file = 'python-2.7.3.msi'


  commands::download{'python.msi':
    url  => "${py_url}/${py_file}",
    file => $py_file,
  }

  package { 'Python 2.7.3':
    ensure          => installed,
    source          => "${::temp}\\python-2.7.3.msi",
    install_options => ['/PASSIVE',],
    require         => Commands::Download['python.msi'],
  }

}

