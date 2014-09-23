class openstack_hyper_v::params {
  # Python base installation
  $python_source                    = undef
  $python_installdir                = 'C:\Python27'
  $easyinstall_source               = undef
  $pip_source                       = undef

  # Python dependencies
  $py_pbr_source                    = undef
  $py_pbr_version                   = latest

  $py_m2crypto_version              = '0.21.1'
#  $py_m2crypto_url                  = 'http://chandlerproject.org/pub/Projects/MeTooCrypto/M2Crypto-0.21.1.win32-py2.7.exe'
  $py_m2crypto_url                  = 'http://10.21.7.22/hv-files/M2Crypto-0.21.1.exe'
  $py_m2crypto_source               = undef

  $py_mysql_version                 = latest #'1.2.3'
  $py_mysql_url                     = 'http://10.21.7.22/hv-files/MySQL-python-1.2.5.win32-py2.7.exe'
#  $py_mysql_url                     = undef #'http://www.codegood.com/download/10/'
  $py_mysql_source                  = undef

  $py_pycrypto_version              = '2.6'
  $py_pycrypto_url                  = 'http://www.voidspace.org.uk/downloads/pycrypto26/pycrypto-2.6.win32-py2.7.exe'
  $py_pycrypto_source               = undef

  $py_pywin32_version               = '217'
  $py_pywin32_url                   = 'http://sourceforge.net/projects/pywin32/files/pywin32/Build%20217/pywin32-217.win32-py2.7.exe/download'
  $py_pywin32_source                = undef

  $py_greenlet_version              = '0.4.3'
  $py_greenlet_url                  = 'https://pypi.python.org/packages/2.7/g/greenlet/greenlet-0.4.3.win32-py2.7.exe'
  $py_greenlet_source               = undef

  $py_lxml_version                  = '2.3'
  $py_lxml_url                      = 'https://pypi.python.org/packages/2.7/l/lxml/lxml-2.3.win32-py2.7.exe#md5=9c02aae672870701377750121f5a6f84'
  $py_lxml_source                   = undef

  $py_eventlet_source               = undef
  $py_eventlet_version              = '0.9.17'

  $py_setuptools_git_source         = undef
  $py_setuptools_git_version        = '0.4.0'

  $py_numpy_version                 = '1.7.1'
  $py_numpy_url                     = 'https://pypi.python.org/packages/2.7/n/numpy/numpy-1.7.1.win32-py2.7.exe'
  $py_numpy_source                  = undef

  $py_oslo_config_source            = undef
  $py_oslo_config_version           = '1.4.0'

  $py_oslo_messaging_source         = undef
  $py_oslo_messaging_version        = '1.4.0'

  $py_pyopenssl_source              = undef
  $py_pyopenssl_url                 = 'https://pypi.python.org/packages/2.7/p/pyOpenSSL/pyOpenSSL-0.13.1.win32-py2.7.exe'
  $py_pyopenssl_version             = '0.13.1'

  $py_virtualenv_source             = undef
  $py_virtualenv_version            = undef
}

