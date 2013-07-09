class hyper_v::iscsi_target {
  notify { "Installing Windows iSCSI TargetFeatures": }
  exec { 'add_iscsi_target_feature':
   path => $::path,
   command => 'c:\Windows\sysnative\WindowsPowerShell\v1.0\powershell.exe -executionpolicy remotesigned -File c:\openstack-puppet-hyper-v\modules\hyper-v\files\iscsi-target.ps1',
   require => Class ['ntp_enable'],
  }
}
