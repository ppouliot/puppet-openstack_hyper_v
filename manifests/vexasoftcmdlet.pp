# Class: windows::vexasoftcmdlet
#
# This module downloads then installs the Vexasoft RDP Powershell cmdlet
#
# Parameters: none
#
# Actions:
#

class windows::vexasoftcmdlet{
  $vexasoft_url  = 'http://cdn.shopify.com/s/files/1/0206/6424/files/Vexasoft_Cmdlet_Library_x64.msi'
  $vexasoft_file = 'Vexasoft_Cmdlet_Library_x64.msi'

  commands::download{'vexasoft-cmdlet-library':
    url  => $vexasoft_url,
    file => $vexasoft_file,
  }

  package { 'Vexasoft_Cmdlet_Library_x64.msi':
    ensure   => installed,
    source   => "${::temp}\\${vexasoft_file}",
    provider => windows,
    require  => Commands::Download['vexasoft-cmdlet-library']
  }
}
