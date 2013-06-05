# Class: windows::greenlet
#
# This module bruteforce installs a precompiled python greenlet module
#
# Parameters: none
#
# Actions:
#
class windows::python::greenlet{

  $greenlet_url   = 'https://pypi.python.org/packages/2.7/g/greenlet/greenlet-0.4.0.win32-py2.7.exe#md5=910896116b1e4fd527b8afaadc7132f3'
  $greenlet_file = 'greenlet-0.4.0-win32-py2.7.exe'

  Commands::Download['greenlet'] -> Commands::Extract_archive['greenlet']

  commands::download{'greenlet':
    url  => $greenlet_url,
    file => $greenlet_file,
  }
  commands::extract_archive{'greenlet':
    archivefile => $greenlet_file,
  }



#  file { 'greenlet-0.4.0-egg':
#    ensure  => 'file',
#    path    => 'C:/Python27/lib/site-packages/greenlet-0.4.0-py2.7.egg-info',
#    source  => 'puppet:///modules/windows/greenlet-0.4.0.win32-py2.7/greenlet-0.4.0-py2.7.egg-info',
#    require => Class['windows::python', 'windows::greenlet'],
#  }

#  file { 'greenlet-0.4.0-h':
#    ensure  => 'file',
#    path    => 'C:\Python27\lib\site-packages\greenlet.h',
#    source  => 'puppet:///modules/windows/greenlet-0.4.0.win32-py2.7/greenlet.h',
#    require => Class['windows::python', 'windows::greenlet'],
#  }

#  file { 'greenlet-0.4.0-pyd':
#    ensure  => 'file',
#    path    => 'C:/Python27/lib/site-packages/greenlet.pyd',
#    source  => 'puppet:///modules/windows/greenlet-0.4.0.win32-py2.7/greenlet.pyd',
#    require => Class['windows::python', 'windows::greenlet'],
#  }

}
