# Class: openstack-hyper-v::base::disable_firewalls
#
# This module disables the OS firewalls on the windows host
#
# Parameters: none
#
# Actions:
#
class openstack-hyper-v::base::disable_firewalls {
  notify { 'Disabling All Windows Firewalls': }
  exec { 'disable_all_firewalls':
    command  => 'Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False',
    provider => powershell,
  }
}
