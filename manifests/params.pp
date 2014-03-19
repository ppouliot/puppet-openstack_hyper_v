class openstack_hyper_v::params {
  # Python base installation
  $python_source                    = undef
  $python_installdir                = 'C:\Python27'
  $easyinstall_source               = undef
  $pip_source                       = undef

  # Python dependencies
  $py_m2crypto_version              = '0.21.1'
  $py_m2crypto_url                  = 'http://chandlerproject.org/pub/Projects/MeTooCrypto/M2Crypto-0.21.1.win32-py2.7.exe'
  $py_m2crypto_source               = undef

  $py_mysql_version                 = '1.2.3'
  $py_mysql_url                     = 'http://www.codegood.com/download/10/'
  $py_mysql_source                  = undef

  $py_pycrypto_version              = '2.6'
  $py_pycrypto_url                  = 'http://www.voidspace.org.uk/downloads/pycrypto26/pycrypto-2.6.win32-py2.7.exe'
  $py_pycrypto_source               = undef

  $py_pywin32_version               = '217'
  $py_pywin32_url                   = 'http://sourceforge.net/projects/pywin32/files/pywin32/Build%20217/pywin32-217.win32-py2.7.exe/download'
  $py_pywin32_source                = undef

  $py_greenlet_version              = '0.4.0'
  $py_greenlet_url                  = 'https://pypi.python.org/packages/2.7/g/greenlet/greenlet-0.4.0.win32-py2.7.exe#md5=910896116b1e4fd527b8afaadc7132f3'
  $py_greenlet_source               = undef

  $py_lxml_version                  = '2.3'
  $py_lxml_url                      = 'https://pypi.python.org/packages/2.7/l/lxml/lxml-2.3.win32-py2.7.exe#md5=9c02aae672870701377750121f5a6f84'
  $py_lxml_source                   = undef

  $py_eventlet_source               = undef
  $py_eventlet_version              = '0.9.17'

  $py_iso8601_source                = undef
  $py_iso8601_version               = '0.1.4'

  $py_webob_source                  = undef
  $py_webob_version                 = '1.2.3'

  $py_netaddr_source                = undef
  $py_netaddr_version               = '0.7.10'

  $py_paste_source                  = undef
  $py_paste_version                 = latest

  $py_pastedeploy_source            = undef
  $py_pastedeploy_version           = '1.5.0'

  $py_repoze_lru_source             = undef
  $py_repoze_lru_version            = '0.6'

  $py_routes_source                 = undef
  $py_routes_version                = '1.12.3'

  $py_wmi_source                    = undef
  $py_wmi_version                   = latest

  $py_sqlalchemy_source             = undef
  $py_sqlalchemy_version            = '0.7.8'

  $py_decorator_source              = undef
  $py_decorator_version             = '3.4.0'

  $py_tempita_source                = undef
  $py_tempita_version               = '0.5.1'

  $py_sqlalchemy_migrate_source     = undef
  $py_sqlalchemy_migrate_version    = '0.7.2'

  $py_amqp_source                   = undef
  $py_amqp_version                  = '1.0.13'

  $py_anyjson_source                = undef
  $py_anyjson_version               = '0.2.4'

  $py_kombu_source                  = undef
  $py_kombu_version                 = '1.0.4'

  $py_boto_source                   = undef
  $py_boto_version                  = latest

  $py_amqplib_source                = undef
  $py_amqplib_version               = '0.6.1'
  
  $py_markdown_source               = undef
  $py_markdown_version              = '2.3.1'

  $py_cheetah_source                = undef
  $py_cheetah_version               = '2.4.4'

  $py_suds_source                   = undef
  $py_suds_version                  = '0.4'

  $py_paramiko_source               = undef
  $py_paramiko_version              = '1.12.0'

  $py_pyasn1_source                 = undef
  $py_pyasn1_version                = latest

  $py_babel_source                  = undef
  $py_babel_version                 = '0.9.6'

  $py_httplib2_source               = undef
  $py_httplib2_version              = latest

  $py_setuptools_git_source         = undef
  $py_setuptools_git_version        = '0.4.0'

  $py_d2to1_source                  = undef
  $py_d2to1_version                 = '0.2.10'

  $py_pbr_source                    = undef
  $py_pbr_version                   = '0.6'

  $py_requests_source               = undef
  $py_requests_version              = '1.1.0'

  $py_simplejson_source             = undef
  $py_simplejson_version             = '3.3.0'

  $py_python_cinderclient_source    = undef
  $py_python_cinderclient_version   = '1.0.1'

  $py_python_quantumclient_source   = undef
  $py_python_quantumclient_version  = '2.2.0'

  $py_six_source                    = undef
  $py_six_version                   = '1.3.0'

  $py_python_keystoneclient_source  = undef
  $py_python_keystoneclient_version = '0.2.0'

  $py_python_glanceclient_source    = undef
  $py_python_glanceclient_version   = '0.9.0'

  $py_stevedore_source              = undef
  $py_stevedore_version             = '0.7'

  $py_numpy_version                 = '1.7.1'
  $py_numpy_url                     = 'https://pypi.python.org/packages/2.7/n/numpy/numpy-1.7.1.win32-py2.7.exe'
  $py_numpy_source                  = undef
 
  $py_websockify_source             = undef
  $py_websockify_version            = '0.3.0'

  $py_oslo_config_source            = undef
  $py_oslo_config_version           = '1.1.0'

  $py_jsonschema_source             = undef
  $py_jsonschema_version            = '2.0.0'

  $py_jsonpointer_source            = undef
  $py_jsonpointer_version           = '1.0'

  $py_jsonpatch_source              = undef
  $py_jsonpatch_version             = '1.1'

  $py_warlock_source                = undef
  $py_warlock_version               = '1.0.1'

  $py_prettytable_source            = undef
  $py_prettytable_version           = '0.6'

  $py_cmd2_source                   = undef
  $py_cmd2_version                  = '0.6.5.1'

  $py_pyparsing_source              = undef
  $py_pyparsing_version             = '1.5.7'

  $py_cliff_source                  = undef
  $py_cliff_version                 = latest

  $py_pyopenssl_source              = undef
  $py_pyopenssl_url                 = 'https://pypi.python.org/packages/2.7/p/pyOpenSSL/pyOpenSSL-0.13.1.win32-py2.7.exe'
  $py_openssl_version               = '0.13.1'

  $py_virtualenv_source             = undef
  $py_virtualenv_version            = undef
}
