# Class: windows::tools::notepadplusplus
#
# This module downloads then installs Notepad++
#
# Parameters: none
#
# Actions:
#

class windows::tools::notepadplusplus {

  $notepadpp_url  = 'http://download.tuxfamily.org/notepadplus/6.3/npp.6.3.Installer.exe'
  $notepadpp_file = 'npp63Installer.exe'


  commands::download{'Notepad-Plus-Plus':
    url  => $notepadpp_url,
    file => $notepadpp_file,
  }

  package { 'Notepad++':
    ensure          => installed,
    source          => "${::temp}\\${notepadpp_file}",
    install_options => ['/S',],
    require         => Commands::Download['Notepad-Plus-Plus'],
  }

}

