class openstack_hyper_v::nova_dependencies inherits openstack_hyper_v::params {

  Class['windows_python'] -> Class['mingw'] -> Windows_python::Dependency<| |>
  
  class { 'mingw': }
   
  class { 'windows_python': 
    python_source      => $python_source,
    python_installdir  => $python_installdir,
    easyinstall_source => $easyinstall_source,
    pip_source         => $pip_source,
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

  windows_python::dependency{ 'iso8601':
    source  => $py_iso8601_source,
    version => $py_iso8601_version,
    type    => pip,
  }

  windows_python::dependency{ 'WebOb':
    source  => $py_webob_source,
    version => $py_webob_version,
    type    => pip,
  }

  windows_python::dependency{ 'netaddr':
    source  => $py_netaddr_source,
    version => $py_netaddr_version,
    type    => pip,
  }

  windows_python::dependency{ 'Paste':
    source  => $py_paste_source,
    version => $py_paste_version,
    type    => pip,
  }

  windows_python::dependency{ 'PasteDeploy':
    source  => $py_pastedeploy_source,
    version => $py_pastedeploy_version,
    type    => pip,
  }

  windows_python::dependency{ 'repoze.lru':
    source  => $py_repoze_lru_source,
    version => $py_repoze_lru_version,
    type    => pip,
  }

  windows_python::dependency{ 'Routes':
    source  => $py_routes_source,
    version => $py_routes_version,
    type    => pip,
    require => Windows_python::Dependency['repoze.lru'],
  }

  windows_python::dependency{ 'WMI':
    source  => $py_wmi_source,
    version => $py_wmi_version,
    type    => pip,
  }

  windows_python::dependency{ 'SQLAlchemy':
    source  => $py_sqlalchemy_source,
    version => $py_sqlalchemy_version,
    type    => pip,
  }

  windows_python::dependency{ 'decorator':
    source  => $py_decorator_source,
    version => $py_decorator_version,
    type    => pip,
  }

  windows_python::dependency{ 'Tempita':
    source  => $py_tempita_source,
    version => $py_tempita_version,
    type    => pip,
  }

  windows_python::dependency{ 'sqlalchemy-migrate':
    source  => $py_sqlalchemy_migrate_source,
    version => $py_sqlalchemy_migrate_version,
    type    => pip,
    require => [Windows_python::Dependency['SQLAlchemy'],
                Windows_python::Dependency['decorator'],
                Windows_python::Dependency['Tempita'],],
  }

  windows_python::dependency{ 'amqp':
    source  => $py_amqp_source,
    version => $py_amqp_version,
    type    => pip,
  }

  windows_python::dependency{ 'anyjson':
    source  => $py_anyjson_source,
    version => $py_anyjson_version,
    type    => pip,
  }

  windows_python::dependency{ 'kombu':
    source  => $py_kombu_source,
    version => $py_kombu_version,
    type    => pip,
    require => [Windows_python::Dependency['anyjson'],
                Windows_python::Dependency['amqp']],
  }

  windows_python::dependency{ 'boto':
    source  => $py_boto_source,
    version => $py_boto_version,
    type    => pip,
  }

  windows_python::dependency{ 'amqplib':
    source  => $py_amqplib_source,
    version => $py_amqplib_version,
    type    => pip,
  }

  windows_python::dependency{ 'Markdown':
    source  => $py_markdown_source,
    version => $py_markdown_version,
    type    => pip,
  }

  windows_python::dependency{ 'Cheetah':
    source  => $py_cheetah_source,
    version => $py_cheetah_version,
    type    => pip,
    require => Windows_python::Dependency['Markdown'],
  }

  windows_python::dependency{ 'suds':
    source  => $py_suds_source,
    version => $py_suds_version,
    type    => pip,
  }

  windows_python::dependency{ 'paramiko':
    source  => $py_paramiko_source,
    version => $py_paramiko_version,
    type    => pip,
    require => Windows_python::Dependency['pycrypto'],
  }

  windows_python::dependency{ 'pyasn1':
    source  => $py_pyasn1_source,
    version => $py_pyasn1_version,
    type    => pip,
  }

  windows_python::dependency{ 'Babel':
    source  => $py_babel_source,
    version => $py_babel_version,
    type    => pip,
  }

  windows_python::dependency{ 'httplib2':
    source  => $py_httplib2_source,
    version => $py_httplib2_version,
    type    => pip,
  }

  windows_python::dependency{ 'setuptools-git':
    source  => $py_setuptools_git_source,
    version => $py_setuptools_git_version,
    type    => pip,
  }

  windows_python::dependency{ 'd2to1':
    source  => $py_d2to1_source,
    version => $py_d2to1_version,
    type    => pip,
  }

  windows_python::dependency{ 'pbr':
    source  => $py_pbr_source,
    version => $py_pbr_version,
    type    => pip,
    require => [Windows_python::Dependency['d2to1'],
                Windows_python::Dependency['setuptools-git']],

  }

  windows_python::dependency{ 'requests':
    source  => $py_requests_source,
    version => $py_requests_version,
    type    => pip,
  }

  windows_python::dependency{ 'simplejson':
    source  => $py_simplejson_source,
    version => $py_simplejson_version,
    type    => pip,
  }

  windows_python::dependency{ 'python-cinderclient':
    source  => $py_python_cinderclient_source,
    version => $py_python_cinderclient_version,
    type    => pip,
    require => [Windows_python::Dependency['prettytable'],
                Windows_python::Dependency['requests'],
                Windows_python::Dependency['simplejson'],],
  }

  windows_python::dependency{ 'python-quantumclient':
    source  => $py_python_quantumclient_source,
    version => $py_python_quantumclient_version,
    type    => pip,
    require => [Windows_python::Dependency['d2to1'],
                Windows_python::Dependency['pbr'],
                Windows_python::Dependency['cliff'],
                Windows_python::Dependency['httplib2'],
                Windows_python::Dependency['iso8601'],
                Windows_python::Dependency['prettytable'],
                Windows_python::Dependency['pyparsing'],
                Windows_python::Dependency['simplejson'],],
  }

  windows_python::dependency{ 'six':
    source  => $py_six_source,
    version => $py_six_version,
    type    => pip,
  }

  windows_python::dependency{ 'python-keystoneclient':
    source  => $py_python_keystoneclient_source,
    version => $py_python_keystoneclient_version,
    type    => pip,
    require => [Windows_python::Dependency['d2to1'],
                Windows_python::Dependency['pbr'],
                Windows_python::Dependency['iso8601'],
                Windows_python::Dependency['prettytable'],
                Windows_python::Dependency['requests'],
                Windows_python::Dependency['simplejson'],
                Windows_python::Dependency['six'],
                Windows_python::Dependency['oslo.config'],],
  }

  windows_python::dependency{ 'python-glanceclient':
    source  => $py_python_glanceclient_source,
    version => $py_python_glanceclient_version,
    type    => pip,
    require => [Windows_python::Dependency['prettytable'],
                Windows_python::Dependency['python-keystoneclient'],
                Windows_python::Dependency['pyopenssl'],
                Windows_python::Dependency['warlock'],],
  }

  windows_python::dependency{ 'stevedore':
    source  => $py_stevedore_source,
    version => $py_stevedore_version,
    type    => pip,
  }

  windows_python::dependency{ 'numpy':
    source     => $py_numpy_source,
    remote_url => $py_numpy_url,
    version    => $py_numpy_version,
    type       => exe,
  }

  windows_python::dependency{ 'websockify':
    source  => $py_websockify_source,
    version => $py_websockify_version,
    type    => pip,
    require => Windows_python::Dependency['numpy'],
  }

  windows_python::dependency{ 'oslo.config':
    source  => $py_oslo_config_source,
    version => $py_oslo_config_version,
    type    => pip,
  }

  windows_python::dependency{ 'jsonschema':
    source  => $py_jsonschema_source,
    version => $py_jsonschema_version,
    type    => pip,
  }

  windows_python::dependency{ 'jsonpointer':
    source  => $py_jsonpointer_source,
    version => $py_jsonpointer_version,
    type    => pip,
  }

  windows_python::dependency{ 'jsonpatch':
    source  => $py_jsonpatch_source,
    version => $py_jsonpatch_version,
    type    => pip,
    require => Windows_python::Dependency['jsonpointer'],
  }

  windows_python::dependency{ 'warlock':
    source  => $py_warlock_source,
    version => $py_warlock_version,
    type    => pip,
    require => [Windows_python::Dependency['jsonschema'], 
                Windows_python::Dependency['jsonpatch']],
  }

  windows_python::dependency{ 'prettytable':
    source  => $py_prettytable_source,
    version => $py_prettytable_version,
    type    => pip,
  }

  windows_python::dependency{ 'cmd2':
    source   => $py_cmd2_source,
    version  => $py_cmd2_version,
    type     => pip,
    require => Windows_python::Dependency['pyparsing'],
  }

  windows_python::dependency{ 'pyparsing':
    source  => $py_pyparsing_source,
    version => $py_pyparsing_version,
    type    => pip,
  }

  windows_python::dependency{ 'cliff':
    source  => $py_cliff_source,
    version => $py_cliff_version,
    type    => pip,
    require => [Windows_python::Dependency['prettytable'], 
                Windows_python::Dependency['cmd2'],
                Windows_python::Dependency['pyparsing'],
                Windows_python::Dependency['pbr'],],
  }

  windows_python::dependency{ 'pyopenssl':
    remote_url => $py_pyopenssl_url,
    source     => $py_pyopenssl_source,
    version    => $py_pyopenssl_version,
    type       => exe,
  }
}
