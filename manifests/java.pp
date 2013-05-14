# Class: windows::java
#
# This module downloads then installs  the Java JRE
#
# Parameters: none
#
# Actions:
#
class windows::java{

  $java_url = $::architecture ? {
    /(x64)/ => 'http://javadl.sun.com/webapps/download/AutoDL?BundleId=75261',
    default => 'http://javadl.sun.com/webapps/download/AutoDL?BundleId=75259',
  }

  $java_file = $::architecture ?{
    /(x64)/ => 'jre-7u17-windows-x64.exe',
    default => 'jre-7u17-windows-i586.exe',
  }

  commands::download{'Java':
    url  => $java_url,
    file => $java_file,
  }

  package { 'Java 7 Update 17':
    ensure          => installed,
    source          => "${::temp}\\${java_file}",
    provider        => 'windows',
    install_options => ['/s', '/v/qn' ADDLOCAL=jrecore REBOOT=Suppress JAVAUPDATE=0''],
  }

}
