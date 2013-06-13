# Class: openstack-hyper-v::7zip
#
# This module downloads then installs 7zip
#
# Parameters: none
#
# Actions:
#

class openstack-hyper-v::tools::7zip(

  $file    = '7z930-x64.msi',
  #$url    = 'http://downloads.sourceforge.net/sevenzip/7z930-x64.msi',
  $url     = 'http://dl.7-zip.org/7z930-x64.msi',
){

  commands::download { '7zip':
    url  => $url,
    file => $file,
  }


  package { '7-Zip 9.30 (x64 edition)':
    ensure   => installed,
    source   => "${::temp}\\${file}",
    require  => Commands::Download['7zip']
  }

}
