# Class: windows::pycrypto
#
# This module downloads then installs Python Mysql Binaries
#
# Parameters: none
#
# Actions:
#

class windows::pycrypto {
  $pycrypto_url = 'http://www.voidspace.org.uk/downloads/pycrypto26/pycrypto-2.6.win32-py2.7.exe'
  $pycrypto_file = 'pycrypto-2.6.win32-py2.7.exe'

  commands::download{'pycrypto-2.6.win32-py27':
    url  => $pycrypto_url,
    file => $pycrypto_file,
  }

  commands::extract_archive{'Extract_PyCrypto':
    archivefile => $pycrypto_file,
  }

#  exec { 'Move_PyMySQL_Files_To_SitePackages':
#    command => "cmd.exe /c mv ${::temp}\\PLATLIB\\* c:\\python27\\Lib\\site-packages\\";
#    require         => Commands::extract_archive['Extract_PyMySQL'],
#  }
#  package { 'Python 2.7 MySQL-python-1.2.3':
#    ensure          => installed,
#    source          => "${::temp}\\${pycrypto_file}",
#    provider        => windows,
#    install_options => '/PASSIVE',
#    require         => Commands::Download['Mysql-Python-1.2.3-win32-py27'],
#  }



}

