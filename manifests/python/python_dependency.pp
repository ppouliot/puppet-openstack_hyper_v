# === Define: openstack_h yper_v::python::python_dependency
#
#  >
#
# === Parameters
#
# [*dependency_name*]
#
# == Examples
#
#  openstack_hyper_v::python::python_dependency { 'M2Crypto':
#    dependency_name => 'Python 2.7 M2Crypto-0.21.1'
#    remote_url      => 'http://chandlerproject.org/pub/Projects/MeTooCrypto/M2Crypto-0.21.1.win32-py2.7.msi'
#    local_path      => "${::temp}\\M2Crypto-0.21.1.win32-py2.7.msi"
#  }
#
#  openstack_hyper_v::python::python_dependency { 'Python 2.7 M2Crypto-0.21.1':
#    remote_url      => 'http://chandlerproject.org/pub/Projects/MeTooCrypto/M2Crypto-0.21.1.win32-py2.7.msi'
#    local_path      => "${::temp}\\M2Crypto-0.21.1.win32-py2.7.msi"
#  }
#
#  openstack_hyper_v::python::python_dependency { 'Python 2.7 M2Crypto-0.21.1':
#    local_path      => "G:\\Software\\Python\\M2Crypto-0.21.1.win32-py2.7.msi"
#  }
#
# == Authors
#
define openstack_hyper_v::python::python_dependency (
  $dependency_name = $title,
  $type,
  $remote_url = undef,
  $local_path = "${::temp}\\${title}.${type}",
){
  if $remote_url {
    openstack_hyper_v::commands::download{$local_path:
      url  => $remote_url,
      file => $local_path,
    }
  }

  case $type {
    exe: {
      commands::extract_archive{"exe-installer-extract-${dependency_name}":
        archivefile => $local_path,
      }

      exec { "move-platlib-${dependency_name}":
        command  => "Copy-Item -Path ${::temp}\\PLATLIB\\* -Destination C:\\python27\\Lib\\site-packages\\ -Force -Recurse; Remove-Item -Path ${::temp}\\PLATLIB -Force -Recurse",
        unless   => "exit Test-Path ${::temp}\\PLATLIB",
        provider => powershell,
        require  => Commands::Extract_archive["exe-installer-extract-${dependency_name}"],
      }

      exec { "move-scripts-${dependency_name}":
        command  => "Copy-Item -Path ${::temp}\\SCRIPTS\\* -Destination C:\\python27\\Scripts\\ -Force -Recurse; Remove-Item -Path ${::temp}\\SCRIPTS -Force -Recurse",
        unless   => "exit Test-Path ${::temp}\\SCRIPTS",
        provider => powershell,
        require  => Commands::Extract_archive["exe-installer-extract-${dependency_name}"],
      }

      exec { "move-headers-${dependency_name}":
        command  => "Copy-Item -Path ${::temp}\\HEADERS\\* -Destination C:\\python27\\ -Force -Recurse; Remove-Item -Path ${::temp}\\HEADERS -Force -Recurse",
        unless   => "exit Test-Path ${::temp}\\HEADERS",
        provider => powershell,
        require  => Commands::Extract_archive["exe-installer-extract-${dependency_name}"],
      }
    }
    msi: {
      package { $dependency_name:
        ensure          => installed,
        source          => $local_path,
        install_options => ['/PASSIVE', {'ALLUSERS'=>'1'},],
        require         => Package['Python 2.7.3'],
      }
    }
    pip: {
      package { $dependency_name:
        ensure   => installed,
        provider => pip,
      }
    }
    default: {
      fail "Invalid installer type: ${type}"
    }
  }  
}
