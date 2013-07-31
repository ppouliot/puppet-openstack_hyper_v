class openstack_hyper_v::python::install(
  $python_source      = "${::temp}\\python.msi",
  $python_package     = 'Python 2.7.3',
  $python_installdir  = 'C:\Python27',
  $easyinstall_source = "${::temp}\\ez_setup.py",
  $pip_source         = "${::temp}\\get-pip.py"
){

  openstack_hyper_v::base::remote_file{'python.msi':
    source      => 'http://www.python.org/ftp/python/2.7.3/python-2.7.3.msi',
    destination => $python_source,
  }

  openstack_hyper_v::base::remote_file{'ez_setup.py':
    source      => 'https://bitbucket.org/pypa/setuptools/raw/0.8/ez_setup.py',
    destination => $easyinstall_source,
  }

  openstack_hyper_v::base::remote_file{'get-pip.py':
    source      => 'https://raw.github.com/pypa/pip/master/contrib/get-pip.py',
    destination => $pip_source,
  }

  package { $python_package:
    ensure          => installed,
    source          => $python_source,
    install_options => ['/PASSIVE', {'ALLUSERS'  => '1'}, {'TARGETDIR' => $python_installdir},],
    require         => Openstack_hyper_v::Base::Remote_file['python.msi'],
  }

  windows_path { $python_installdir:
    ensure  => present,
    require => Package[$python_package],
  }

  windows_path { "${python_installdir}\\Scripts":
    ensure  => present,
    require => Package[$python_package],
  }

  exec { 'install-pip':
    command  => "& python.exe ${pip_source}",
    creates  => "${python_installdir}\\Scripts\\pip.exe",
    unless   => "exit !(Test-Path \"${python_installdir}\\Scripts\\pip.exe\")",
    provider => powershell,
    require  => [Openstack_hyper_v::Base::Remote_file['get-pip.py'], Windows_path[$python_installdir]],
  }

  exec { 'install-ez':
    command  => "& python.exe ${easyinstall_source}",
    creates  => "${python_installdir}\\Scripts\\easy_install.exe",
    unless   => "exit !(Test-Path \"${python_installdir}\\Scripts\\easy_install.exe\")",
    provider => powershell,
    require  => [Openstack_hyper_v::Base::Remote_file['ez_setup.py'], Windows_path[$python_installdir]],
  }
}
