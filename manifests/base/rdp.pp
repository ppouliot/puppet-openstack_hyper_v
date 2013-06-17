# Class: openstack-hyper-v::base::rdp
#
# This module enables RDP access to the windows host and allows the more flexible method of connectivity
#
# Parameters: none
#
# Actions:
#

class openstack-hyper-v::base::rdp {

  exec { 'enable_rdp_connection':
    command  => '(Get-WmiObject win32_TerminalServiceSetting -Namespace root\\cimv2\\TerminalServices).SetAllowTSConnections(1)',
    provider => powershell,
  }

  exec { 'set_rdp_supported_clients':
    command  => 'Set-RemoteDesktopConfig -Enable -AllowOlderClients',
    provider => powershell,
    require  => Package['VexasoftCmdletLibrary_x64'],
  }

}
