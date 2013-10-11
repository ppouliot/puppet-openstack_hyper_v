class openstack_hyper_v::nova_dependencies inherits openstack_hyper_v::params {

  Class['openstack_hyper_v::python::install'] -> Openstack_hyper_v::Python::Dependency<| |>

  class { 'openstack_hyper_v::python::install': 
    python_source      => $python_source,
    python_installdir  => $python_installdir,
    easyinstall_source => $easyinstall_source,
    pip_source         => $pip_source,
  }

  openstack_hyper_v::python::dependency{ 'M2Crypto':
    remote_url => $py_m2crypto_url,
    source     => $py_m2crypto_source,
    version    => $py_m2crypto_version,
    type       => exe,
  }

  openstack_hyper_v::python::dependency{ 'MySQL-python':
    remote_url => $py_mysql_url,
    source     => $py_mysql_source,
    version    => $py_mysql_version,
    type       => exe,
  }

  openstack_hyper_v::python::dependency{ 'pycrypto':
    remote_url => $py_pycrypto_url,
    source     => $py_pycrypto_source,
    version    => $py_pycrypto_version,
    type       => exe,
  }

  openstack_hyper_v::python::dependency{ 'pywin32':
    remote_url => $py_pywin32_url,
    source     => $py_pywin32_source,
    version    => $py_pywin32_version,
    type       => exe,
  }

  exec { 'pywin32-postinstall-script':
    command     => "${python_installdir}/python.exe ${python_installdir}/Scripts/pywin32_postinstall.py -install",
    refreshonly => true,
    subscribe   => Openstack_hyper_v::Python::Dependency['pywin32'],
  }

  openstack_hyper_v::python::dependency{ 'greenlet':
    remote_url => $py_greenlet_url,
    source     => $py_greenlet_source,
    version    => $py_greenlet_version,
    type       => exe,
  }

  openstack_hyper_v::python::dependency{ 'lxml':
    remote_url => $py_lxml_url,
    source     => $py_lxml_source,
    version    => $py_lxml_version,
    type       => exe,
  }

  openstack_hyper_v::python::dependency{ 'eventlet':
    source  => $py_eventlet_source,
    version => $py_eventlet_version,
    type    => pip,
    require => Openstack_hyper_v::Python::Dependency['greenlet'],
  }

  openstack_hyper_v::python::dependency{ 'iso8601':
    source  => $py_iso8601_source,
    version => $py_iso8601_version,
    type    => pip,
  }

  openstack_hyper_v::python::dependency{ 'WebOb':
    source  => $py_webob_source,
    version => $py_webob_version,
    type    => pip,
  }

  openstack_hyper_v::python::dependency{ 'netaddr':
    source  => $py_netaddr_source,
    version => $py_netaddr_version,
    type    => pip,
  }

  openstack_hyper_v::python::dependency{ 'Paste':
    source  => $py_paste_source,
    version => $py_paste_version,
    type    => pip,
  }

  openstack_hyper_v::python::dependency{ 'PasteDeploy':
    source  => $py_pastedeploy_source,
    version => $py_pastedeploy_version,
    type    => pip,
  }

  openstack_hyper_v::python::dependency{ 'repoze.lru':
    source  => $py_repoze_lru_source,
    version => $py_repoze_lru_version,
    type    => pip,
  }

  openstack_hyper_v::python::dependency{ 'Routes':
    source  => $py_routes_source,
    version => $py_routes_version,
    type    => pip,
    require => Openstack_hyper_v::Python::Dependency['repoze.lru'],
  }

  openstack_hyper_v::python::dependency{ 'WMI':
    source  => $py_wmi_source,
    version => $py_wmi_version,
    type    => pip,
  }

  openstack_hyper_v::python::dependency{ 'SQLAlchemy':
    source  => $py_sqlalchemy_source,
    version => $py_sqlalchemy_version,
    type    => pip,
  }

  openstack_hyper_v::python::dependency{ 'decorator':
    source  => $py_decorator_source,
    version => $py_decorator_version,
    type    => pip,
  }

  openstack_hyper_v::python::dependency{ 'Tempita':
    source  => $py_tempita_source,
    version => $py_tempita_version,
    type    => pip,
  }

  openstack_hyper_v::python::dependency{ 'sqlalchemy-migrate':
    source  => $py_sqlalchemy_migrate_source,
    version => $py_sqlalchemy_migrate_version,
    type    => pip,
    require => [Openstack_hyper_v::Python::Dependency['SQLAlchemy'],
                Openstack_hyper_v::Python::Dependency['decorator'],
                Openstack_hyper_v::Python::Dependency['Tempita'],],
  }

  openstack_hyper_v::python::dependency{ 'amqp':
    source  => $py_amqp_source,
    version => $py_amqp_version,
    type    => pip,
  }

  openstack_hyper_v::python::dependency{ 'anyjson':
    source  => $py_anyjson_source,
    version => $py_anyjson_version,
    type    => pip,
  }

  openstack_hyper_v::python::dependency{ 'kombu':
    source  => $py_kombu_source,
    version => $py_kombu_version,
    type    => pip,
    require => [Openstack_hyper_v::Python::Dependency['anyjson'],
                Openstack_hyper_v::Python::Dependency['amqp']],
  }

  openstack_hyper_v::python::dependency{ 'boto':
    source  => $py_boto_source,
    version => $py_boto_version,
    type    => pip,
  }

  openstack_hyper_v::python::dependency{ 'amqplib':
    source  => $py_amqplib_source,
    version => $py_amqplib_version,
    type    => pip,
  }

  openstack_hyper_v::python::dependency{ 'Markdown':
    source  => $py_markdown_source,
    version => $py_markdown_version,
    type    => pip,
  }

  openstack_hyper_v::python::dependency{ 'Cheetah':
    source  => $py_cheetah_source,
    version => $py_cheetah_version,
    type    => pip,
    require => Openstack_hyper_v::Python::Dependency['Markdown'],
  }

  openstack_hyper_v::python::dependency{ 'suds':
    source  => $py_suds_source,
    version => $py_suds_version,
    type    => pip,
  }

  openstack_hyper_v::python::dependency{ 'paramiko':
    source  => $py_paramiko_source,
    version => $py_paramiko_version,
    type    => pip,
    require => Openstack_hyper_v::Python::Dependency['pycrypto'],
  }

  openstack_hyper_v::python::dependency{ 'pyasn1':
    source  => $py_pyasn1_source,
    version => $py_pyasn1_version,
    type    => pip,
  }

  openstack_hyper_v::python::dependency{ 'Babel':
    source  => $py_babel_source,
    version => $py_babel_version,
    type    => pip,
  }

  openstack_hyper_v::python::dependency{ 'httplib2':
    source  => $py_httplib2_source,
    version => $py_httplib2_version,
    type    => pip,
  }

  openstack_hyper_v::python::dependency{ 'setuptools-git':
    source  => $py_setuptools_git_source,
    version => $py_setuptools_git_version,
    type    => pip,
  }

  openstack_hyper_v::python::dependency{ 'd2to1':
    source  => $py_d2to1_source,
    version => $py_d2to1_version,
    type    => pip,
  }

  openstack_hyper_v::python::dependency{ 'pbr':
    source  => $py_pbr_source,
    version => $py_pbr_version,
    type    => pip,
    require => [Openstack_hyper_v::Python::Dependency['d2to1'],
                Openstack_hyper_v::Python::Dependency['setuptools-git']],

  }

  openstack_hyper_v::python::dependency{ 'requests':
    source  => $py_requests_source,
    version => $py_requests_version,
    type    => pip,
  }

  openstack_hyper_v::python::dependency{ 'simplejson':
    source  => $py_simplejson_source,
    version => $py_simplejson_version,
    type    => pip,
  }

  openstack_hyper_v::python::dependency{ 'python-cinderclient':
    source  => $py_python_cinderclient_source,
    version => $py_python_cinderclient_version,
    type    => pip,
    require => [Openstack_hyper_v::Python::Dependency['prettytable'],
                Openstack_hyper_v::Python::Dependency['requests'],
                Openstack_hyper_v::Python::Dependency['simplejson'],],
  }

  openstack_hyper_v::python::dependency{ 'python-quantumclient':
    source  => $py_python_quantumclient_source,
    version => $py_python_quantumclient_version,
    type    => pip,
    require => [Openstack_hyper_v::Python::Dependency['d2to1'],
                Openstack_hyper_v::Python::Dependency['pbr'],
                Openstack_hyper_v::Python::Dependency['cliff'],
                Openstack_hyper_v::Python::Dependency['httplib2'],
                Openstack_hyper_v::Python::Dependency['iso8601'],
                Openstack_hyper_v::Python::Dependency['prettytable'],
                Openstack_hyper_v::Python::Dependency['pyparsing'],
                Openstack_hyper_v::Python::Dependency['simplejson'],],
  }

  openstack_hyper_v::python::dependency{ 'six':
    source  => $py_six_source,
    version => $py_six_version,
    type    => pip,
  }

  openstack_hyper_v::python::dependency{ 'python-keystoneclient':
    source  => $py_python_keystoneclient_source,
    version => $py_python_keystoneclient_version,
    type    => pip,
    require => [Openstack_hyper_v::Python::Dependency['d2to1'],
                Openstack_hyper_v::Python::Dependency['pbr'],
                Openstack_hyper_v::Python::Dependency['iso8601'],
                Openstack_hyper_v::Python::Dependency['prettytable'],
                Openstack_hyper_v::Python::Dependency['requests'],
                Openstack_hyper_v::Python::Dependency['simplejson'],
                Openstack_hyper_v::Python::Dependency['six'],
                Openstack_hyper_v::Python::Dependency['oslo.config'],],
  }

  openstack_hyper_v::python::dependency{ 'python-glanceclient':
    source  => $py_python_glanceclient_source,
    version => $py_python_glanceclient_version,
    type    => pip,
    require => [Openstack_hyper_v::Python::Dependency['prettytable'],
                Openstack_hyper_v::Python::Dependency['python-keystoneclient'],
                Openstack_hyper_v::Python::Dependency['pyopenssl'],
                Openstack_hyper_v::Python::Dependency['warlock'],],
  }

  openstack_hyper_v::python::dependency{ 'stevedore':
    source  => $py_stevedore_source,
    version => $py_stevedore_version,
    type    => pip,
  }

  openstack_hyper_v::python::dependency{ 'numpy':
    source     => $py_numpy_source,
    remote_url => $py_numpy_url,
    version    => $py_numpy_version,
    type       => exe,
  }

  openstack_hyper_v::python::dependency{ 'websockify':
    source  => $py_websockify_source,
    version => $py_websockify_version,
    type    => pip,
    require => Openstack_hyper_v::Python::Dependency['numpy'],
  }

  openstack_hyper_v::python::dependency{ 'oslo.config':
    source  => $py_oslo_config_source,
    version => $py_oslo_config_version,
    type    => pip,
  }

  openstack_hyper_v::python::dependency{ 'jsonschema':
    source  => $py_jsonschema_source,
    version => $py_jsonschema_version,
    type    => pip,
  }

  openstack_hyper_v::python::dependency{ 'jsonpointer':
    source  => $py_jsonpointer_source,
    version => $py_jsonpointer_version,
    type    => pip,
  }

  openstack_hyper_v::python::dependency{ 'jsonpatch':
    source  => $py_jsonpatch_source,
    version => $py_jsonpatch_version,
    type    => pip,
    require => Openstack_hyper_v::Python::Dependency['jsonpointer'],
  }

  openstack_hyper_v::python::dependency{ 'warlock':
    source  => $py_warlock_source,
    version => $py_warlock_version,
    type    => pip,
    require => [Openstack_hyper_v::Python::Dependency['jsonschema'], 
                Openstack_hyper_v::Python::Dependency['jsonpatch']],
  }

  openstack_hyper_v::python::dependency{ 'prettytable':
    source  => $py_prettytable_source,
    version => $py_prettytable_version,
    type    => pip,
  }

  openstack_hyper_v::python::dependency{ 'cmd2':
    source   => $py_cmd2_source,
    version  => $py_cmd2_version,
    type     => pip,
    require => Openstack_hyper_v::Python::Dependency['pyparsing'],
  }

  openstack_hyper_v::python::dependency{ 'pyparsing':
    source  => $py_pyparsing_source,
    version => $py_pyparsing_version,
    type    => pip,
  }

  openstack_hyper_v::python::dependency{ 'cliff':
    source  => $py_cliff_source,
    version => $py_cliff_version,
    type    => pip,
    require => [Openstack_hyper_v::Python::Dependency['prettytable'], 
                Openstack_hyper_v::Python::Dependency['cmd2'],
                Openstack_hyper_v::Python::Dependency['pyparsing'],],
  }

  openstack_hyper_v::python::dependency{ 'pyopenssl':
    source     => $py_pyopenssl_source,
    remote_url => $py_pyopenssl_url,
    type       => egg,
  }
}
