class hyper-v::set_vm_migration_network {
  notify { "Set VM Migration Network": }
  exec { 'set_vm_migration_net':
   path => $winpath,
   command => 'c:\Windows\sysnative\WindowsPowerShell\v1.0\powershell.exe -executionpolicy remotesigned -File c:\openstack-puppet-hyper-v\modules\hyper-v\files\set_vm_migration_net.ps1',
   require => Class['enable_live_migration'],
  }
}
