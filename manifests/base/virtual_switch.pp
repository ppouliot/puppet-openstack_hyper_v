# == Class: openstack-hyper-v::base::virtual_switch
#
# This class is responsible of configuring a virtual switch on the Hyper-V hypervisors
#
# == Parameters
#
# [*name*]
#   Specify the name of the virtual switch that will be created on the host
# [*notes*]
#   Descriptive notes to be associated to the virtual switch in the hypervisor
# [*interface_address*]
#   This option is available when an 'External' switch is being configured, the interface address is used to get 
#   the physical adapter name. The default value corresponds to the ipaddress fact
# [*switch_type*]
#   Specify the connection type the switch will be connected to: 'External', 'Internal' or 'Private'
# [*os_managed*]
#   This option is available when an 'External' switch is used, it allows managament OS to share the interface
# == Examples
#
#  class { 'openstack-hyper-v::base::virtual_switch':
#    name => 'br100',
#  }
#
#  class { 'openstack-hyper-v::base::virtual_switch':
#    name            => 'internal_switch',
#    connection_type => 'Internal',
#  }
#
#  class { 'openstack-hyper-v::base::virtual_switch':
#    name   => 'switch_to_be_removed',
#    enable => false,
#  }
#
#  class { 'openstack-hyper-v::base::virtual_switch':
#    name              => 'external-switch-nic-2'
#    notes             => 'Switch linked to non default address',
#    interface_address => '192.168.0.1',
#    switch_type       => 'External',
#    os_managed        => false,
#  }
#
# == Authors
#
# Peter Pouliot peter@pouliot.net
# Octavian Ciuhandu ociuhandu@cloudbasesolutions.com
# Luis Fernandez Alvarez luis.fernandez.alvarez@cern.ch
# 
class openstack-hyper-v::base::virtual_switch(
  $enable = true,
  $name,
  $notes = 'Puppet managed virtual switch',
  $interface_address = $::ipaddress,
  $switch_type = 'External',
  $os_managed = true,
){

  if $enable {
    $get_adapter = "\$if = Get-NetIPAddress –IPAddress ${interface_address} | Get-NetIPInterface;"
    $creation_command = $switch_type ? {
      'External' => "${get_adapter} New-VMSwitch -SwitchType ${switch_type} -Name ${name} -Notes ${notes} -NetAdapterName \$if.ifAlias -AllowManagementOS \$${os_managed}",
      default => "New-VMSwitch -SwitchType ${switch_type} -Name ${name} -Notes ${notes}",
    }

    exec {'create-vm-switch':
      command  => $creation_command,
      unless   => "exit !(Get-VMSwitch ${name})",
      provider => powershell,
    }

    exec { 'update-notes':
      command  => "Set-VMSwitch -Name ${name} -Notes ${notes}",
      unless   => "if ((Get-VMSwitch).Notes -ne ${notes}) { exit 1 }",
      provider => powershell,
      require  => Exec['create-vm-switch'],
    }

    $update_type_command = $switch_type ? {
      'External' => "${get_adapter} Set-VMSwitch -SwitchType ${switch_type} -Name ${name} -NetAdapterName \$if.ifAlias",
      default => "Set-VMSwitch -SwitchType ${switch_type} -Name ${name}",
    }

    exec { 'update-switch-type':
      command  => $update_type_command,
      unless   => "exit (Get-VMSwitch).SwitchType -ne ${switch_type}",
      provider => powershell,
      require  => Exec['create-vm-switch'],
    }

    if $switch_type == 'External' {
      exec {'update-interface':
        command  => "${get_adapter} Set-VMSwitch -Name ${name} -NetAdapterName \$if.ifAlias",
        unless   => "${get_adapter} exit ((Get-VMSwitch).NetAdapterName -ne \$if.ifAlias)",
        provider => powershell,
        require  => Exec['create-vm-switch'],
      }

      exec {'update-os-management':
        command  => "Set-VMSwitch -Name ${name} -AllowManagementOS \$${os_managed}",
        unless   => "exit ((Get-VMSwitch).AllowManagementOS -ne \$${os_managed})",
        provider => powershell,
        require  => Exec['create-vm-switch'],
      }
    }
  }else{
    exec {'remove-vm-switch':
      command  => "Remove-VMSwitch ${name} -Force",
      unless   => "exit @(Get-VMSwitch ${name}).Count -eq 1",
      provider => powershell,
    }
  }
}
