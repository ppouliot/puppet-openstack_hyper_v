# === Class: openstack_hyper_v::python::install
#
# This module contains the basic installation of Python on Windows environments.
# It installs: Python, pip and easy_install in the system, making them available
# through the system PATH.
#
# The default parameters are configured to install Python 2.7.3.
#
# === Parameters
#
# [*python_source*]
#   Path to python msi installer. If the value is undef, the default is
#   %TEMP%\python.msi and the data is downloaded from python_remote.
# [*python_remote*]
#   Remote location where the python msi installer can be downloaded. Defaults
#   to Python 2.7.3 installer on python.org. Valid values: http url.
# [*python_package*]
#   Name used to install the python package, it must follow the puppet rules for
#   packages on windows.
# [*python_installdir*]
#   Full path where Python should be installed. Defaults to C:\Python27.
# [*easyinstall_source*]
#   Path to easy_install py installer. If the value is undef, the default is
#   %TEMP%\ez_setup.py and the data is downloaded from easyinstall_remote.
# [*easyinstall_remote*]
#   Remote location where the easy_install py installer can be downloaded.
#   Defaults to the official link. Valid values: http url.
# [*pip_source*]
#   Path to pip py installer. If the value is undef, the default is 
#   %TEMP%\get-pip.py and the data is donwloaded from pip_remote.
# [*pip_remote*]
#   Remote location where the pip py installer can be downloaded. Defaults to
#   the official link. Valid values: http url.
#
# == Examples
#
#  class { 'openstack_hyper_v::python::install': }
#
#  class { 'openstack_hyper_v::python::install': 
#    python_source      => 'G:\SharedStorage\Software\Python\Python-3.3.2.msi',
#    python_package     => 'Python 3.3.2',
#    python_installdir  => 'C:\Python33',
#    easyinstall_source => 'G:\SharedStorage\Software\Python\ez_setup.py',
#    pip_source => 'G:\SharedStorage\Software\Python\get-pip.py',
#  }
#
#  class { 'openstack_hyper_v::python::install':
#    python_remote      => "http://internal.web.server/python-2.7.3.msi",
#    easyinstall_remote => "http://internal.web.server/ez_setup.py",
#    pip_remote         => "http://internal.web.server/get-pip.py",
#  }
#
# == Authors
#
class openstack_hyper_v::python::install(
  $python_source      = undef,
  $python_remote      = $::openstack_hyper_v::python::params::python_remote,
  $python_package     = $::openstack_hyper_v::python::params::python_package,
  $python_installdir  = $::openstack_hyper_v::python::params::python_installdir,
  $easyinstall_source = undef,
  $easyinstall_remote = $::openstack_hyper_v::python::params::easyinstall_remote,
  $pip_source         = undef,
  $pip_remote         = $::openstack_hyper_v::python::params::pip_remote,
) inherits openstack_hyper_v::python::params {

  if $python_source == undef {
    $python_source_real = $::openstack_hyper_v::python::params::python_source

    windows_common::remote_file{'python.msi':
      source      => $python_remote,
      destination => $python_source_real,
      before      => Package[$python_package],
    }
  } else {
    $python_source_real = $python_source
  }

  if $easyinstall_source == undef {
    $easyinstall_source_real = $::openstack_hyper_v::python::params::easyinstall_source

    windows_common::remote_file{'ez_setup.py':
      source      => $easyinstall_remote,
      destination => $easyinstall_source_real,
      before      => Exec['install-ez'],
    }
  } else {
    $easyinstall_source_real = $easyinstall_source
  }

  if $pip_source == undef {
    $pip_source_real = $::openstack_hyper_v::python::params::pip_source

    windows_common::remote_file{'get-pip.py':
      source      => $pip_remote,
      destination => $pip_source_real,
      before      => Exec['install-pip'],
    }
  } else {
    $pip_source_real = $pip_source
  }

  package { $python_package:
    ensure          => installed,
    source          => $python_source_real,
    install_options => ['/PASSIVE', {'ALLUSERS'  => '1'}, {'TARGETDIR' => $python_installdir},],
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
    command  => "& python.exe ${pip_source_real}",
    creates  => "${python_installdir}\\Scripts\\pip.exe",
    unless   => "exit !(Test-Path -Path '${python_installdir}\\Scripts\\pip.exe')",
    provider => powershell,
    require  => Windows_path[$python_installdir],
  }

  exec { 'install-ez':
    command  => "& python.exe ${easyinstall_source_real}",
    creates  => "${python_installdir}\\Scripts\\easy_install.exe",
    unless   => "exit !(Test-Path -Path '${python_installdir}\\Scripts\\easy_install.exe')",
    provider => powershell,
    require  => Windows_path[$python_installdir],
  }
}
