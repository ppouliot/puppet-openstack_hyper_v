# == Define: openstack_hyper_v::base::windows_feature
#
# It allows the configuration of the Windows features.
#
# === Parameters
#
# [*name*]
#
# [*ensure*]
#   This parameter specifies if the feature must be 'present' or 'absent' in
#   the system.
#
# === Examples
#
#  openstack_hyper_v::base::windows_feature { 'Hyper-V':
#    ensure => present,
#  }
#
# === Authors
#
# === Copyright
#
define openstack_hyper_v::base::windows_feature($ensure){
  case $ensure {
    present: {
      exec { "add-windows-feature_${name}":
        command  => "Add-WindowsFeature -Name ${name}",
        unless   => "if(!(Get-WindowsFeature ${name}).Installed){ exit 1 }",
        provider => powershell,
      }
    }
    absent: {
      exec { "remove-windows-feature-${name}":
        command  => "Remove-WindowsFeature -name ${name}",
        unless   => "if((Get-WindowsFeature ${name}).Installed){ exit 1 }",
        provider => powershell,
      }
    }
    default: {
      fail "Invalid 'ensure' value '$ensure' for openstack_hyper_v::base::windows_feature"
    }
  }
}
