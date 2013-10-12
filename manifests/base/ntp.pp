# Class: openstack_hyper_v::base::ntp
#
# This class configures NTP and the Timezone for a windows host
#
# Parameters: none
#
# Actions:
#

class openstack_hyper_v::base::ntp (

    $timeserver = 'bonehed.lcs.mit.edu',
    $timezone   = 'Eastern Standard Time',
){
  exec {'set_time_zone':
    command => "tzutil.exe /s \"${timezone}\"",
	provider => powershell,
  }

  service { 'w32time':
    ensure => 'running',
    enable => true,
	before => Exec['w32tm_update_time'],
  }

  exec { 'stop_time':
    command => 'net.exe stop w32time',
	before  => [Service['w32time'], Exec['set_time_peer'],Exec['w32tm_update_time'],],
	onlyif	=> "If ( ((Get-Service W32Time).Status -eq \"Stopped\")){exit 1}",
	provider => powershell,
    }

  exec { 'set_time_peer':
    command => "w32tm.exe /config /manualpeerlist:\"${timeserver},0x8\" /syncfromflags:MANUAL",
    notify  => [Service['w32time'],Exec['w32tm_update_time'],],
	provider => powershell,
	before => Service['w32time'],
  }

  exec {'w32tm_update_time':
    command     => 'w32tm.exe /config /update',
    refreshonly => true,
	provider => powershell,
  }

}

