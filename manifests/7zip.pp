# Class: windows::7zip
#
# This module downloads then installs 7zip
#
# Parameters: none
#
# Actions:
#

class windows::7zip(

  $file    = '7z930-x64.msi',
  #$url    = 'http://downloads.sourceforge.net/sevenzip/7z930-x64.msi',
  $url     = 'http://dl.7-zip.org/7z930-x64.msi',
){

  commands::download { '7zip':
    url  => $url,
    file => $file,
  }


  package { '7z930-x64':
    ensure   => installed,
    source   => "${::temp}\\${file}",
    provider => windows,
    require  => Commands::Download['7zip']
  }

}
