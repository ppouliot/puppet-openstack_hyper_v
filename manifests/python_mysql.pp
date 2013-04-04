# Class: windows::python_mysql
#
# This module downloads then installs Python Mysql Binaries
#
# Parameters: none
#
# Actions:
#

class windows::python_mysql {
  $pymysql_url = 'http://www.codegood.com/download/10/'
  $pymysql_file = 'MySQL-python-1.2.3.win32-py2.7.exe'

  commands::download{'Mysql-Python-1.2.3-win32-py27':
    url  => $pymysql_url,
    file => $pymysql_file,
  }

  package { 'Mysql-Python-1.2.3-win32-py27.exe':
    ensure          => installed,
    source          => "${::temp}\\python-2.7.3.msi",
    provider        => windows,
    install_options => '/PASSIVE',
    require         => Commands::Download['Mysql-Python-1.2.3-win32-py27'],
  }



}

