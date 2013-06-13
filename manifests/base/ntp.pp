# Class: openstack-hyper-v::base::ntp
#
# This class configures NTP and the Timezone for a windows host
#
# Parameters: none
#
# Actions:
#

class openstack-hyper-v::base::ntp {

    $timeserver = 'bonehed.lcs.mit.edu'
    $timezone   = 'Eastern Standard Time'

  exec {'set_time_zone':
    command => "tzutil.exe /s \"${timezone}\"",
  }

  service { 'w32time':
    ensure => 'running',
    enable => true,
    before => Exec['stop_time'],
  }

  exec { 'stop_time':
    command => 'net.exe stop w32time',
    before  => Exec['set_time_peer'],
    }

  exec { 'set_time_peer':
    command => "w32tm.exe /config /manualpeerlist:${timeserver},0x8 /syncfromflags:MANUAL",
    notify  => Exec['w32tm_update_time'],
  }

  exec {'w32tm_update_time':
    command     => 'w32tm.exe /config /update',
    refreshonly => true,
  }

}

