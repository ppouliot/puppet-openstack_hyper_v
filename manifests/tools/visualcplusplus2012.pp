# Class: openstack-hyper-v::tools::visualcplusplus2012
#
# This module downloads then installs Visual C++ 2012
#
# Parameters: none
#
# Actions:
#

class openstack-hyper-v::tools::visualcplusplus2012{
  $vs2012_url  = 'http://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU1/vcredist_x86.exe'
  $vs2012_file = 'vcredist_x86.exe'


  commands::download{'Visual_Studio_2012_C_Plus_Plus':
    url  => $vs2012_url,
    file => $vs2012_file,
  }

  package { 'vcredist_x86.exe':
    ensure          => installed,
    source          => "${::temp}\\${vs2012_file}",
    install_options => ['/PASSIVE'],
    require         => Commands::Download['Visual_Studio_2012_C_Plus_Plus'],
  }


}
