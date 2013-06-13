# Class: openstack-hyper-v::pycrypto
#
# This module downloads then installs Python Mysql Binaries
#
# Parameters: none
#
# Actions:
#

class openstack-hyper-v::python::pycrypto {
  $pycrypto_url = 'http://www.voidspace.org.uk/downloads/pycrypto26/pycrypto-2.6.win32-py2.7.exe'
  $pycrypto_file = 'pycrypto-2.6.win32-py2.7.exe'

  Commands::Download['pycrypto'] -> Commands::Extract_archive['pycrypto']

  commands::download{'pycrypto':
    url  => $pycrypto_url,
    file => $pycrypto_file,
  }

  commands::extract_archive{'pycrypto':
    archivefile => $pycrypto_file,
  }

#  exec { 'Move_PyMySQL_Files_To_SitePackages':
#    command => "cmd.exe /c mv ${::temp}\\PLATLIB\\* c:\\python27\\Lib\\site-packages\\";
#    require         => Commands::extract_archive['Extract_PyMySQL'],
#  }
#  package { 'Python 2.7 MySQL-python-1.2.3':
#    ensure          => installed,
#    source          => "${::temp}\\${pycrypto_file}",
#    install_options => '/PASSIVE',
#    require         => Commands::Download['Mysql-Python-1.2.3-win32-py27'],
#  }



}

