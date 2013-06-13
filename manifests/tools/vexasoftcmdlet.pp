# Class: openstack-hyper-v::tools::vexasoftcmdlet
#
# This module downloads then installs the Vexasoft RDP Powershell cmdlet
#
# Parameters: none
#
# Actions:
#

class openstack-hyper-v::tools::vexasoftcmdlet{
  $vexasoft_url  = 'http://cdn.shopify.com/s/files/1/0206/6424/files/Vexasoft_Cmdlet_Library_x64.msi'
  $vexasoft_file = 'Vexasoft_Cmdlet_Library_x64.msi'

  commands::download{'vexasoft-cmdlet-library':
    url  => $vexasoft_url,
    file => $vexasoft_file,
  }

  package { 'VexasoftCmdletLibrary_x64':
    ensure   => installed,
    source   => "${::temp}\\${vexasoft_file}",
    require  => Commands::Download['vexasoft-cmdlet-library']
  }
}
