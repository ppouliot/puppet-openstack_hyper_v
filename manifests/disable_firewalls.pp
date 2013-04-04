# Class: windows::disable_firewalls
#
# This module disables the OS firewalls on the windows host
#
# Parameters: none
#
# Actions:
#
class windows::disable_firewalls {
  notify { 'Disabling All Windows Firewalls': }
  exec { 'disable_all_firewalls':
    path    => $::winpath,
    command => 'powershell.exe -executionpolicy remotesigned -Command Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False',
  }
}
