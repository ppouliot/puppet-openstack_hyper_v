class openstack_hyper_v::nova_dependencies {

  Class['openstack_hyper_v::python::install'] -> Openstack_hyper_v::Python::Dependency<| |>

  class { 'openstack_hyper_v::python::install':}

  openstack_hyper_v::python::dependency{ 'Python 2.7 M2Crypto-0.21.1':
    remote_url => 'http://chandlerproject.org/pub/Projects/MeTooCrypto/M2Crypto-0.21.1.win32-py2.7.msi',
    type       => msi,
  }

  openstack_hyper_v::python::dependency{ 'MySQL_python-1.2.3-py2.7':
    remote_url => 'http://www.codegood.com/download/10/',
    type       => exe,
  }

  openstack_hyper_v::python::dependency{ 'pycrypto-2.6-py2.7':
    remote_url => 'http://www.voidspace.org.uk/downloads/pycrypto26/pycrypto-2.6.win32-py2.7.exe',
    type       => exe,
  }

  openstack_hyper_v::python::dependency{ 'pywin32-217-py2.7':
    remote_url => 'http://sourceforge.net/projects/pywin32/files/pywin32/Build%20217/pywin32-217.win32-py2.7.exe/download',
    type       => exe,
  }

  exec { 'pywin32-postinstall-script':
    command     => 'C:/Python27/python.exe C:/Python27/Scripts/pywin32_postinstall.py -install',
    refreshonly => true,
    subscribe   => Openstack_hyper_v::Python::Dependency['pywin32-217-py2.7'],
  }

  openstack_hyper_v::python::dependency{ 'greenlet-0.4.0-py2.7':
    remote_url => 'https://pypi.python.org/packages/2.7/g/greenlet/greenlet-0.4.0.win32-py2.7.exe#md5=910896116b1e4fd527b8afaadc7132f3',
    type       => exe,
  }

  openstack_hyper_v::python::dependency{ 'lxml-2.3-py2.7':
    remote_url => 'https://pypi.python.org/packages/2.7/l/lxml/lxml-2.3.win32-py2.7.exe#md5=9c02aae672870701377750121f5a6f84',
    type       => exe,
  }

  openstack_hyper_v::python::dependency{ 'eventlet':
    type    => pip,
    require => Openstack_hyper_v::Python::Dependency['greenlet-0.4.0-py2.7'],
  }

  openstack_hyper_v::python::dependency{ 'iso8601':
    type => pip,
  }

  openstack_hyper_v::python::dependency{ 'WebOb':
    type => pip,
  }

  openstack_hyper_v::python::dependency{ 'netaddr':
    type => pip,
  }

  openstack_hyper_v::python::dependency{ 'Paste':
    type => pip,
  }

  openstack_hyper_v::python::dependency{ 'PasteDeploy':
    type => pip,
  }

  openstack_hyper_v::python::dependency{ 'Routes':
    type => pip,
  }

  openstack_hyper_v::python::dependency{ 'WMI':
    type => pip,
  }

  openstack_hyper_v::python::dependency{ 'SQLAlchemy':
    type => pip,
  }

  openstack_hyper_v::python::dependency{ 'sqlalchemy-migrate':
    type => pip,
  }

  openstack_hyper_v::python::dependency{ 'kombu':
    type => pip,
  }
}

