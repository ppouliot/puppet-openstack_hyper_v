# == Class: openstack-hyper-v::base::live_migration
#
# This class is responsible of configuring the live migration on the Hyper-V hypervisors
#
# == Parameters
#
# [*enable*]
#   Specify if the migration should be enabled or not in the hypervisor
# [*authentication_type*]
#   Determine the authentication method used for migration: 'Kerberos' or 'CredSSP'
# [*allowed_networks*]
#   Contains a comma separated list of the networks allowed to perform the migration.
#   If this value is undef, any network will be allowed to perform the live migration.
# [*simultaneous_storage_migrations*]
#   Number of simultaneous storage migrations
# [*simultaneous_live_migrations*]
#   Number of simultaneous live migrations
#
# == Examples
#
#  class { 'openstack-hyper-v::base::live_migration':
#    enabled                      => true,
#    authentication_type          => 'Kerberos',
#    simultaneous_live_migrations => 3,
#  }
#
#  class { 'openstack-hyper-v::base::live_migration':
#    enabled          => true,
#    allowed_networks => '192.168.0.0/24,10.0.0.0/16'
#  }
#
# == Authors
#
# Peter Pouliot peter@pouliot.net
# Octavian Ciuhandu ociuhandu@cloudbasesolutions.com
# Luis Fernandez Alvarez luis.fernandez.alvarez@cern.ch
#
class openstack-hyper-v::base::live_migration(
  $enable = true,
  $authentication_type = 'Kerberos',
  $allowed_networks = undef,
  $simultaneous_storage_migrations = 2,
  $simultaneous_live_migrations = 2,
) {

  if $enable {
    exec{ 'enable-live-migration':
      command  => 'Enable-VMMigration',
      unless   => 'if (!(Get-VMHost).VirtualMachineMigrationEnabled) { exit 1 }',
      provider => powershell,
    }

    exec{ 'set-authentication-type':
      command  => "Set-VMHost -VirtualMachineMigrationAuthenticationType ${authentication_type}",
      unless   => "if (!(Get-VMHost).VirtualMachineMigrationAuthenticationType -eq [Microsoft.HyperV.PowerShell.MigrationAuthenticationType]::${authentication_type}) { exit 1 }",
      provider => powershell,
    }

    exec{ 'set-simultaneous-storage-migrations':
      command  => "Set-VMHost -MaximumStorageMigrations ${simultaneous_storage_migrations}",
      unless   => "if ((Get-VMHost).MaximumStorageMigrations -ne ${simultaneous_storage_migrations}) { exit 1 }",
      provider => powershell,
    }

    exec{ 'set-simultaneous-live-migrations':
      command  => "Set-VMHost -MaximumVirtualMachineMigrations ${simultaneous_live_migrations}",
      unless   => "if ((Get-VMHost).MaximumVirtualMachineMigrations -ne ${simultaneous_live_migrations}) { exit 1 }",
      provider => powershell,
    }

    $desired_any_network_state = inline_template("<%= @allowed_networks ? '\$False': '\$True'  %>")
    
    exec{ 'set-any-network-migration':
        command  => "Set-VMHost -UseAnyNetworkForMigration ${desired_any_network_state}",
        unless   => "if ((Get-VMHost).UseAnyNetworkForMigration -ne ${desired_any_network_state}) { exit 1 }",
        provider => powershell,
    }

    if $allowed_networks != undef {
      exec{ 'set-migration-networks':
        command  => "Remove-VMMigrationNetwork *; '${allowed_networks}'.Split(',') | ForEach { Add-VMMigrationNetwork \$_ }",
        unless   => "'${allowed_networks}'.Split(',') | ForEach { if(@(Get-VMMigrationNetwork \$_).Count -eq 0){ exit 1 }  }",
        provider => powershell,
      }
    }else
    {
      exec{ 'remove-migration-networks':
        command  => "Remove-VMMigrationNetwork *",
        unless   => 'if (@(Get-VMMigrationNetwork).Count -ne 0){ exit 1 }',
        provider => powershell,
      }
    }
  }else{
    exec{ 'disable-live-migration':
      command  => 'Disable-VMMigration',
      unless   => 'if ((Get-VMHost).VirtualMachineMigrationEnabled) { exit 1 }',
      provider => powershell,
    }
  }
}
