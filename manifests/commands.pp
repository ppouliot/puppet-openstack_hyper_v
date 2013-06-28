# Class: openstack-hyper-v::commands
#
# This module defines reused commands for windows
#
# Parameters: none
#
# Actions:
#

class openstack-hyper-v::commands{
  define download($url,$file){
    exec{ $name:
      # Depreciated: PP -> REmoving to test new Powershell metnod for downloading content.
      # command => "Invoke-WebRequest -UseBasicParsing -uri ${url} -OutFile ${file}",
      command  => "(new-object Net.WebClient).DownloadFile(\'${url}\',\'${::temp}\\${file}\')",
      creates  => "${::temp}\\${file}",
      unless   => "exit !(Get-Item ${::temp}\\${file})",
      provider => powershell,
    }
  }

  define add_windows_feature(){
    exec { "ps_add_feature_${name}":
      command  => "Add-WindowsFeature -Name ${name}",
      unless   => "if(!(Get-WindowsFeature ${name}).Installed){ exit 1 }",
      provider => powershell,
    }
  }
  define remove_windows_feature{
    exec { "ps_remove_feature-${name}":
      command  => "Remove-WindowsFeature -name ${name}",
      unless   => "if((Get-WindowsFeature ${name}).Installed){ exit 1 }",
      provider => powershell,
    }
  }

  # Define: openstack-hyper-v::commands::create_ad_domain
  # Create an Active Directory Domain
  #
  define create_ad_domain ( $::domain_name, $::netbios_name, $::domain_user, $::domain_passwd,){
    exec {'create_active_directory_domain':
      command  => "Install-ADDSForest -CreateDNSDelegation:\$false -DatabasePath \"${::windir}\\NTDS\" --DomainMode \"Win2012\" -DomainName \"${::domain_name}\" -DomainNetbiosName \"${::netbiso_name}\" -ForestMode \"Win2012\" -InstallDNS:\$true -LogPath \"${::windir}\\NTDS\" -NoRebootOnCompletion:\$false -SysVolPath \"${::windir}\\SYSVOL\" -Force:\$true",
      unless   => 'Import-Module ADDSDeployment',
      provider => powershell,
    }
  }

  #
  # Define: openstack-hyper-v::commands::join_ad_domain
  # Join an Active Directory Domain
  #
  define join_ad_domain ( $::domain_user, $::domain_passwd,){
    exec { 'join_domain':
      command  => "Add-Computer -DomainName ${name} -credential (New-Object System.Management.Automation.PSCredential ${name}\\${::domain_user},(ConvertTo-SecureString \"${::domain_passwd}\" -AsPlainText -Force)) -Restart",
      provider => powershell,
      # unless  => '(Get-ComputerInfo).IsDomainJoined',
      # notify  => Exec['reboot-windows'],
    }
  }

  #
  # Reboot Windows
  #

  exec {'reboot-windows':
    path        => $::path,
    command     => 'cmd.exe /c shutdown.exe -R -T 60',
    refreshonly => true,
  }

  define map_drive ( $::drive_letter, $::server, $::share ){
    $drive_letter = $name
    exec { "mount-${name}":
      command => "net.exe use ${::drive_letter} \\\\${::server}\\${::share} /persist:yes",
      creates => "${drive_letter}/",
    }
  }

  define unmap_drive {
    $drive_letter = $name
    exec { "unmount-${name}":
      command     => "net.exe use ${drive_letter} /delete",
    }
  }

  define extract_archive ($archivefile){
    exec {"7z_extract_${name}":
      command => "7z.exe x -y ${::temp}\\${archivefile}",
      path    => "${programw6432}\\7-Zip;${::path}",
      cwd     => $::temp,
      require => Package['7-Zip 9.30 (x64 edition)'],
    }
  }
}
