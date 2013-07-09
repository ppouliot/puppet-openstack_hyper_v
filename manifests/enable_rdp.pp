class hyper_v::enable_rdp {
  notify { "Allowing Terminal Service Connections": }
  exec { 'allow_ts_connection':
   path => $::path,
   command => 'c:\Windows\sysnative\WindowsPowerShell\v1.0\powershell.exe -executionpolicy remotesigned -File c:\openstack-puppet-hyper-v\modules\hyper-v\files\enable_rdp.ps1',
   require => Class [ 'disable_firewalls' ],
  }
}
