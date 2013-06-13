class hyper-v::set_migration_auth_kerberos {
  }
  notify { 'Setting Migration Authentication Kerrberos": }
  exec { 'migration_auth':
   path => $winpath,
   command => 'c:\Windows\sysnative\WindowsPowerShell\v1.0\powershell.exe -executionpolicy remotesigned -File c:\openstack-puppet-hyper-v\modules\hyper-v\files\set_migration_auth.ps1',
  require => Class ['set_vm_migration_network']
  }

}
