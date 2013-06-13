# Class: windows::pywin32
#
# This module downloads then installs Pywin32-217-py27
#
# Parameters: none
#
# Actions:
#

class windows::python::pywin32 {
  $pywin32_url  = 'http://sourceforge.net/projects/pywin32/files/pywin32/Build%20217/pywin32-217.win32-py2.7.exe/download'
  $pywin32_file = 'pywin32-217.win32-py2.7.exe'

  Commands::Download['pywin32'] -> Commands::Extract_archive['pywin32']

  commands::download{'pywin32':
    url  => $pywin32_url,
    file => $pywin32_file,
  }
  commands::extract_archive{'pywin32':
    archivefile => $pywin32_file,
  }




#  package { 'Python 2.7 pywin32-217':
#    ensure          => installed,
#    source          => "${::temp}\\${pywin32_file}",
#    require         => Commands::Download['pywin32'],
#  }





# file { 'pywin32-217':
#   ensure  => 'directory',
#   path    => 'C:/Python27/lib/site-packages/',
#   source  => 'puppet:///modules/windows/pywin32-217.win32-py2.7',
#   recurse => true,
#   require => Class['windows::python'],
#   before  => Exec['pywin32_post_install'],
# }

# exec { 'pywin32_post_install':
#   command => 'C:/Python27/python.exe C:/Python27/Lib/site-packages/pywin32_postinstall.py -install',
# }
}
