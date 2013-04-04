# Class: windows::commands
#
# This module defines reused commands for windows
#
# Parameters: none
#
# Actions:
#


class windows::commands{
  define download($url,$file){
    exec{ $name:
      path    => $::path,
      command => "powershell.exe -executionpolicy remotesigned -Command Invoke-WebRequest -UseBasicParsing -uri ${url} -OutFile ${file}",
      creates => "${::temp}\\${file}",
      cwd     => $::temp,
      unless  => "cmd.exe /c if not exist ${::temp}\\${file}",
    }
  }

  define add_windows_feature(){
    exec { "ps_add_feature_${name}":
      path    => $::path,
      command => "powershell.exe -executionpolicy remotesigned -Command Add-WindowsFeature -Name ${name}",
    }
  }
  define remove_windows_feature{
    exec { "ps_remove_feature-${name}":
      path    => $::path,
      command => "powershell.exe -executionpolicy remotesigned -Command Remove-WindowsFeature -name ${name}",
    }
  }

  define hyperv_vswitch($::interface_ip,){
    exec {"hyper-v_create_vswitch_${name}":
      path    => $::path,
      command => "powershell.exe -executionpolicy remotesigned -Command New-VmSwitch -NetAdapterName (Get-NetIPAddress -IPAddress ${::interface_ip}).InterfaceAlias -Name ${name} -AllowManagementOS \$true",
      unless  => "powershell.exe -executionpolicy remotesigned -Command Get-VMSwitch -Name ${name}",
    }
  }
  define hyperv_remove_vswitch{
    exec {"hyper-v_remove_vswitch_${name}":
      path    => $::path,
      command => "powershell.exe -executionpolicy remotesigned -Command Remove-VMSwitch -Name ${name} -Force",
    }
  }


  # Define: windows::commands::create_ad_domain
  # Create an Active Directory Domain
  #
  define create_ad_domain ( $::domain_name, $::netbios_name, $::domain_user, $::domain_passwd,){
    exec {'create_active_directory_domain':
      command => "powershell.exe -executionpolicy remotesigned -Command Install-ADDSForest -CreateDNSDelegation:\$false -DatabasePath \"${::windir}\\NTDS\" --DomainMode \"Win2012\" -DomainName \"${::domain_name}\" -DomainNetbiosName \"${::netbiso_name}\" -ForestMode \"Win2012\" -InstallDNS:\$true -LogPath \"${::windir}\\NTDS\" -NoRebootOnCompletion:\$false -SysVolPath \"${::windir}\\SYSVOL\" -Force:\$true",
      unless  => 'powershell.exe -executionpolicy remotesigned -Command Import-Module ADDSDeployment',
    }
  }

  #
  # Define: windows::commands::join_ad_domain
  # Join an Active Directory Domain
  #
  define join_ad_domain ( $::domain_user, $::domain_passwd,){
    exec { 'join_domain':
      path    => $::path,
      command => "powershell.exe -executionpolicy remotesigned -Command Add-Computer -DomainName ${name} -credential (New-Object System.Management.Automation.PSCredential ${name}\\${::domain_user},(ConvertTo-SecureString \"${::domain_passwd}\" -AsPlainText -Force)) -Restart",
#     unless  => 'powershell.exe -executionpolicy remotesigned -Command (Get-ComputerInfo).IsDomainJoined',
#     notify  => Exec['reboot-windows'],
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

  define extract_archive ($::archivefile){
    exec {"7z_extract_${name}":
      command => "7z.exe x ${::temp}\\${::archivefile}",
      path    => "${programw6432}\\7-Zip;${::path}",
      cwd     => $::temp,
      require => Package['7z930-x64'],
    }
  }
}
