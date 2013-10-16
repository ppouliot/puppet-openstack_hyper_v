# === Define: openstack_h yper_v::python::dependency
#
#  >
#
# === Parameters
#
# [*name*]
# [*version*]
# [*source*]
# [*url*]
# [*type*]
#
# == Examples
#
#  openstack_hyper_v::python::dependency { 'M2Crypto':
#    name => 'Python 2.7 M2Crypto-0.21.1'
#    remote_url      => 'http://chandlerproject.org/pub/Projects/MeTooCrypto/M2Crypto-0.21.1.win32-py2.7.msi'
#    soure      => "${::temp}\\M2Crypto-0.21.1.win32-py2.7.msi"
#  }
#
#  openstack_hyper_v::python::dependency { 'Python 2.7 M2Crypto-0.21.1':
#    remote_url      => 'http://chandlerproject.org/pub/Projects/MeTooCrypto/M2Crypto-0.21.1.win32-py2.7.msi'
#    source      => "${::temp}\\M2Crypto-0.21.1.win32-py2.7.msi"
#  }
#
#  openstack_hyper_v::python::dependency { 'Python 2.7 M2Crypto-0.21.1':
#    source      => "G:\\Software\\Python\\M2Crypto-0.21.1.win32-py2.7.msi"
#  }
#
# == Authors
#
define openstack_hyper_v::python::dependency (
  $type,
  $remote_url = undef,
  $source     = undef,
  $version    = latest,
){
  case $type {
    egg: {
      if $source == undef {
        if $remote_url == undef {
          if $version != latest {
			 $source_real = "$name==$version"
		   } else {
		     $source_real = $name
		     }
        } else {        
          $source_real = "${::temp}\\${title}.${type}"
          windows_common::remote_file{ $source_real:
            source      => $remote_url,
            destination => $source_real,
            before      => Exec["egg-python-dependency-${name}"],
          }
        }
      } else {
        $source_real = $source
      }

      exec{ "egg-python-dependency-${name}":
        command  => "& easy_install.exe '${source_real}'",
        unless   => "exit !(Select-String -Simple '${name}' -Path C:\\Python27\\Lib\\site-packages\\easy-install.pth -Quiet)",
        provider => powershell,
      }
    }
    exe: {
      if $source == undef {
        $source_real = "${::temp}\\${title}.${type}"
        windows_common::remote_file{ $source_real:
          source      => $remote_url,
          destination => $source_real,
          before      => Openstack_hyper_v::Base::Extract_file["exe-installer-extract-${name}"],
        }
      } else {
        $source_real = $source
      }

      openstack_hyper_v::base::extract_file{"exe-installer-extract-${name}":
        file        => $source_real,
        destination => $::temp,
      }

      exec { "trigger-python-dependency-${name}":
        command  => "Write-Output \"Installing python dependency: ${name}",
        unless   => "\$output = pip freeze; exit !(\$output.Contains('${name}==${version}'))",
        provider => powershell,
        notify   => Openstack_hyper_v::Base::Extract_file["exe-installer-extract-${name}"],
      }

      exec { "move-platlib-${name}":
        command     => "Copy-Item -Path ${::temp}\\PLATLIB\\* -Destination C:\\python27\\Lib\\site-packages\\ -Force -Recurse; Remove-Item -Path ${::temp}\\PLATLIB -Force -Recurse",
        unless      => "exit (Test-Path -Path '${::temp}\PLATLIB')",
        provider    => powershell,
        refreshonly => true,
        subscribe   => Openstack_hyper_v::Base::Extract_file["exe-installer-extract-${name}"],
      }

      exec { "move-scripts-${name}":
        command     => "Copy-Item -Path ${::temp}\\SCRIPTS\\* -Destination C:\\python27\\Scripts\\ -Force -Recurse; Remove-Item -Path ${::temp}\\SCRIPTS -Force -Recurse",
        unless      => "exit (Test-Path -Path '${::temp}\SCRIPTS')",
        provider    => powershell,
        refreshonly => true,
        subscribe   => Openstack_hyper_v::Base::Extract_file["exe-installer-extract-${name}"],
      }

      exec { "move-headers-${name}":
        command     => "Copy-Item -Path ${::temp}\\HEADERS\\* -Destination C:\\python27\\ -Force -Recurse; Remove-Item -Path ${::temp}\\HEADERS -Force -Recurse",
        unless      => "exit (Test-Path -Path '${::temp}\HEADERS')",
        provider    => powershell,
        refreshonly => true,
        subscribe   => Openstack_hyper_v::Base::Extract_file["exe-installer-extract-${name}"],
      }
    }
    msi: {
      if $source == undef {
        $source_real = "${::temp}\\${title}.${type}"
        windows_common::remote_file{ $source_real:
          source      => $remote_url,
          destination => $source_real,
          before      => Package[$name],
        }
      } else {
        $source_real = $source
      }

      package { $name:
        ensure          => installed,
        source          => $source_real,
        install_options => ['/PASSIVE', {'ALLUSERS'=>'1'},],
      }
    }
    pip: {
      package { $name:
        source   => $source,
        ensure   => $version,
        provider => pip,
      }
    }
    default: {
      fail "Invalid installer type: ${type}"
    }
  }  
}
