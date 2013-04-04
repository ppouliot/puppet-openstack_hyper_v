# Class: windows::notepadplusplus
#
# This module downloads then installs Notepad++
#
# Parameters: none
#
# Actions:
#

class windows::notepadplusplus {

  $notepadpp_url  = 'http://download.tuxfamily.org/notepadplus/6.3/npp.6.3.Installer.exe'
  $notepadpp_file = 'npp63Installer.exe'


  commands::download{'Notepad-Plus-Plus':
    url  => $notepadpp_url,
    file => $notepadpp_file,
  }

  package { 'Notepad-Plus-Plus-msi':
    ensure          => installed,
    source          => "${::temp}\\${notepadpp_file}",
    provider        => windows,
    install_options => ['/S',],
    require         => Commands::Download['Notepad-Plus-Plus'],
  }

}

