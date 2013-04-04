# Class: windows::lxml
#
# This bruteforce installs lxm from precompiled binary for windows
#
# Parameters: none
#
# Actions:
#

class windows::lxml{

  file { 'lxml-2.3-py2.7.egg':
    ensure  => 'directory',
    path    => 'C:/Python27/lib/site-packages/lxml-2.3-py2.7.egg',
    source  => 'puppet:///modules/windows/lxml-2.3-py2.7.egg-info',
    recurse => true,
#   require => Class['windows::python', 'windows::pywin32'],
  }

  file { 'lxml':
    ensure  => 'directory',
    path    => 'C:/Python27/lib/site-packages/lxml',
    source  => 'puppet:///modules/windows/lxml',
    recurse => true,
#   require => Class['windows::python', 'windows::pywin32'],
  }

}
