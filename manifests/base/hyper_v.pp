# === Class: openstack_hyper_v
#
# This module contains basic configuration tasks for Microsoft Hyper-V
#
# === Parameters
#
# [*ensure_powershell*]
#   Specify if the Hyper-V Module for Windows PowerShell will be installed
#   in the host. Defaults to present. Valid values are: absent/present.
# [*ensure_tools*]
#   Specify if the Hyper-V GUI Management Tools are installed. Defaults
#   to absent. Valid values are: absent/present.
#
# == Examples
#
#  class { 'openstack_hyper_v::base::hyper_v': }
#
# == Authors
#
class openstack_hyper_v::base::hyper_v (
  $ensure_powershell = present,
  $ensure_tools      = absent,
){

  openstack_hyper_v::base::windows_feature {'Hyper-V':
    ensure => present,
  }

  exec {'Hyper-V Restart':
    command     => "shutdown.exe /r /t 0",
    path        => $::path,
    refreshonly => true,
    subscribe   => Openstack_hyper_v::Base::Windows_feature['Hyper-V']
  }

  openstack_hyper_v::base::windows_feature {'Hyper-V-Tools':
     ensure  => $ensure_tools,
     require => Openstack_hyper_v::Base::Windows_feature['Hyper-V'],
  }

  openstack_hyper_v::base::windows_feature {'Hyper-V-PowerShell':
     ensure  => $ensure_powershell,
     require => Openstack_hyper_v::Base::Windows_feature['Hyper-V'],
  }
}
