# Class: openstack_hyper_v::python
#
# This module downloads then installs Python 2.7.3
#
# Parameters: none
#
# Actions:
#

class openstack_hyper_v::python {

  Package['Python 2.7.3'] -> Exec['install-ez'] -> Exec['install-pip'] -> Openstack_hyper_v::Python::Python_dependency<| |>

  openstack_hyper_v::commands::download{'python.msi':
    url  => 'http://www.python.org/ftp/python/2.7.3/python-2.7.3.msi',
    file => "${::temp}\\python-2.7.3.msi",
  }

  openstack_hyper_v::commands::download{'ez_setup.py':
    url  => 'https://bitbucket.org/pypa/setuptools/raw/0.8/ez_setup.py',
    file => "${::temp}\\ez_setup.py",
  }

  openstack_hyper_v::commands::download{'get-pip.py':
    url  => 'https://raw.github.com/pypa/pip/master/contrib/get-pip.py',
    file => "${::temp}\\get-pip.py",
  }

  package { 'Python 2.7.3':
    ensure          => installed,
    source          => "${::temp}\\python-2.7.3.msi",
    install_options => ['/PASSIVE', {'ALLUSERS'=>'1'}],
    require         => Openstack_hyper_v::Commands::Download['python.msi'],
  }

  exec { 'install-pip':
    command  => "& C:\\Python27\\python.exe ${::temp}\\get-pip.py",
    creates  => 'C:\Python27\Scripts\pip.exe',
    unless   => 'exit !(Get-Item C:\Python27\Scripts\pip.exe)',
    provider => powershell,
    require  => [Package['Python 2.7.3'], Openstack_hyper_v::Commands::Download['get-pip.py']],
  }

  exec { 'install-ez':
    command  => "& C:\\Python27\\python.exe ${::temp}\\ez_setup.py",
    creates  => 'C:\Python27\Scripts\easy_install.exe',
    unless   => 'exit !(Get-Item C:\Python27\Scripts\easy_install.exe)',
    provider => powershell,
    require  => [Package['Python 2.7.3'], Openstack_hyper_v::Commands::Download['ez_setup.py']],
  }

  openstack_hyper_v::python::python_dependency{ 'Python 2.7 M2Crypto-0.21.1':
    remote_url => 'http://chandlerproject.org/pub/Projects/MeTooCrypto/M2Crypto-0.21.1.win32-py2.7.msi',
    type       => msi,
  }

  openstack_hyper_v::python::python_dependency{ 'MySQL_python-1.2.3-py2.7':
    remote_url => 'http://www.codegood.com/download/10/',
    type       => exe,
  }

  openstack_hyper_v::python::python_dependency{ 'pycrypto-2.6-py2.7':
    remote_url => 'http://www.voidspace.org.uk/downloads/pycrypto26/pycrypto-2.6.win32-py2.7.exe',
    type       => exe,
  }

  openstack_hyper_v::python::python_dependency{ 'pywin32-217-py2.7':
    remote_url => 'http://sourceforge.net/projects/pywin32/files/pywin32/Build%20217/pywin32-217.win32-py2.7.exe/download',
    type       => exe,
  }

  exec { 'pywin32-postinstall-script':
    command => 'C:/Python27/python.exe C:/Python27/Scripts/pywin32_postinstall.py -install',
    require => Openstack_hyper_v::Python::Python_dependency['pywin32-217-py2.7'],
  }

  openstack_hyper_v::python::python_dependency{ 'greenlet-0.4.0-py2.7':
    remote_url => 'https://pypi.python.org/packages/2.7/g/greenlet/greenlet-0.4.0.win32-py2.7.exe#md5=910896116b1e4fd527b8afaadc7132f3',
    type       => exe,
  }

  openstack_hyper_v::python::python_dependency{ 'lxml-2.3-py2.7':
    remote_url => 'https://pypi.python.org/packages/2.7/l/lxml/lxml-2.3.win32-py2.7.exe#md5=9c02aae672870701377750121f5a6f84',
    type       => exe,
  }

  openstack_hyper_v::python::python_dependency{ 'eventlet':
    type       => pip,
  }

  openstack_hyper_v::python::python_dependency{ 'iso8601':
    type       => pip,
  }

  openstack_hyper_v::python::python_dependency{ 'webob':
    type       => pip,
  }

  openstack_hyper_v::python::python_dependency{ 'netaddr':
    type       => pip,
  }

  openstack_hyper_v::python::python_dependency{ 'paste':
    type       => pip,
  }

  openstack_hyper_v::python::python_dependency{ 'pastedeploy':
    type       => pip,
  }

  openstack_hyper_v::python::python_dependency{ 'routes':
    type       => pip,
  }

  openstack_hyper_v::python::python_dependency{ 'wmi':
    type       => pip,
  }

  openstack_hyper_v::python::python_dependency{ 'sqlalchemy':
    type       => pip,
  }

  openstack_hyper_v::python::python_dependency{ 'sqlalchemy-migrate':
    type       => pip,
  }

  openstack_hyper_v::python::python_dependency{ 'kombu':
    type       => pip,
  }
}

