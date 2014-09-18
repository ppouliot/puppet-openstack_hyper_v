class openstack_hyper_v::nova_dependencies inherits openstack_hyper_v::params {

  Class['windows_python'] -> Class['mingw'] -> Windows_python::Dependency<| |>
  
  class { 'mingw': }
   
   class { 'windows_python':
    python_source      => $python_source,
    python_installdir  => $python_installdir,
    easyinstall_source => $easyinstall_source,
    pip_source         => $pip_source,
  }

  file { "C:/Python27/Lib/site-packages/posix_ipc-0.9.8-py2.7.egg-info":
      ensure             => file,
      source             => "puppet:///extra_files/hv-files/posix_ipc-0.9.8-py2.7.egg-info",
      require            => Class['windows_python'],
    }

  file { "C:/Python27/Lib/site-packages/posix_ipc.pyd":
      ensure             => file,
      source             => "puppet:///extra_files/hv-files/posix_ipc.pyd",
      require            => Class['windows_python'],
    }

 windows_python::dependency{ 'pbr':
    source  => $py_pbr_source,
    version => $py_pbr_version,
    type    => pip,
  }

  windows_python::dependency{ 'M2Crypto':
    remote_url => $py_m2crypto_url,
    source     => $py_m2crypto_source,
    version    => $py_m2crypto_version,
    type       => exe,
  }

  windows_python::dependency{ 'MySQL-python':
    remote_url => $py_mysql_url,
    source     => $py_mysql_source,
    version    => $py_mysql_version,
    type       => exe,
  }

  windows_python::dependency{ 'pycrypto':
    remote_url => $py_pycrypto_url,
    source     => $py_pycrypto_source,
    version    => $py_pycrypto_version,
    type       => exe,
  }

  windows_python::dependency{ 'pywin32':
    remote_url => $py_pywin32_url,
    source     => $py_pywin32_source,
    version    => $py_pywin32_version,
    type       => exe,
  }

  exec { 'pywin32-postinstall-script':
    command     => "${python_installdir}/python.exe ${python_installdir}/Scripts/pywin32_postinstall.py -install",
    refreshonly => true,
    subscribe   => Windows_python::Dependency['pywin32'],
  }

  windows_python::dependency{ 'greenlet':
    remote_url => $py_greenlet_url,
    source     => $py_greenlet_source,
    version    => $py_greenlet_version,
    type       => exe,
  }

  windows_python::dependency{ 'lxml':
    remote_url => $py_lxml_url,
    source     => $py_lxml_source,
    version    => $py_lxml_version,
    type       => exe,
  }

  windows_python::dependency{ 'virtualenv':
    source  => $py_virtualenv_source,
    version => $py_virtualenv_version,
    type    => pip,
  }

  windows_python::dependency{ 'eventlet':
    source  => $py_eventlet_source,
    version => $py_eventlet_version,
    type    => pip,
    require => Windows_python::Dependency['greenlet'],
  }

  windows_python::dependency{ 'setuptools-git':
    source  => $py_setuptools_git_source,
    version => $py_setuptools_git_version,
    type    => pip,
  }

  windows_python::dependency{ 'numpy':
    source     => $py_numpy_source,
    remote_url => $py_numpy_url,
    version    => $py_numpy_version,
    type       => exe,
  }

  windows_python::dependency{ 'oslo.config':
    source  => $py_oslo_config_source,
    version => $py_oslo_config_version,
    type    => pip,
  }

  windows_python::dependency{ 'oslo.messaging':
    source  => $py_oslo_messaging_source,
    version => $py_oslo_messaging_version,
    type    => pip,
  }

  windows_python::dependency{ 'pyopenssl':
    remote_url => $py_pyopenssl_url,
    source     => $py_pyopenssl_source,
    version    => $py_pyopenssl_version,
    type       => exe,
  }
}
