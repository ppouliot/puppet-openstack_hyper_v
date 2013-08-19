class openstack_hyper_v::python::params {
  $python_source      = "${::temp}\\python.msi"
  $python_remote      = 'http://www.python.org/ftp/python/2.7.3/python-2.7.3.msi'
  $python_package     = 'Python 2.7.3'
  $python_installdir  = 'C:\Python27'
  $easyinstall_source = "${::temp}\\ez_setup.py"
  $easyinstall_remote = 'https://bitbucket.org/pypa/setuptools/raw/0.8/ez_setup.py'
  $pip_source         = "${::temp}\\get-pip.py"
  $pip_remote         = 'https://raw.github.com/pypa/pip/master/contrib/get-pip.py'
}
