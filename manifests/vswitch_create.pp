class hyper-v::vswitch_create {
  notify { "Creating the Hyper-V Virtual switching infrastructrue": }
  exec { 'set_hv_vswitch':
   path => $winpath,
   command => 'c:\Windows\sysnative\WindowsPowerShell\v1.0\powershell.exe -executionpolicy remotesigned -File c:\openstack-puppet-hyper-v\modules\hyper-v\files\vswitch_create.ps1',
   require => Class [ 'disable_firewalls' ],
  }
}
