# === Class: openstack_hyper_v
#
# This module contains basic configuration tasks for Microsoft Hyper-V
#
# === Parameters
#
# == Examples
#
#  class { 'openstack_hyper_v::base::hyper_v': }
#
# == Authors
#
class openstack_hyper_v::base::hyper_v {

  openstack_hyper_v::base::windows_feature {'Hyper-V':
    ensure => present,
  }

  exec {'Hyper-V Restart':
    command     => "shutdown.exe /r /t 0",
    path        => $::path,
    refreshonly => true,
    subscribe   => Openstack_hyper_v::Base::Windows_feature['Hyper-V']
  }

  openstack_hyper_v::base::windows_feature {'RSAT-Hyper-V-Tools':
     ensure  => present,
     require => Openstack_hyper_v::Base::Windows_feature['Hyper-V'],
  }
}
