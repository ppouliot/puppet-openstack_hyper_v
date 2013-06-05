# Class: windows::python_mysql
#
# This module downloads then installs Python Mysql Binaries
#
# Parameters: none
#
# Actions:
#

class windows::python::mysql_python {

  $pymysql_url = 'http://www.codegood.com/download/10/'
  $pymysql_file = 'MySQL-python-1.2.3.win32-py2.7.exe'

  Commands::Download['mysql_python'] -> Commands::Extract_archive['mysql_python']

  commands::download{'mysql_python':
    url  => $pymysql_url,
    file => $pymysql_file,
  }

  commands::extract_archive{'mysql_python':
    archivefile => $pymysql_file,
  }

#  exec { 'Move_PyMySQL_Files_To_SitePackages':
#    command => "cmd.exe /c mv ${::temp}\\PLATLIB\\* c:\\python27\\Lib\\site-packages\\";
#    require         => Commands::extract_archive['Extract_PyMySQL'],
#  }
#  package { 'Python 2.7 MySQL-python-1.2.3':
#    ensure          => installed,
#    source          => "${::temp}\\${pymysql_file}",
#    provider        => windows,
#    install_options => '/PASSIVE',
#    require         => Commands::Download['Mysql-Python-1.2.3-win32-py27'],
#  }



}

