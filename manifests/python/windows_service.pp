# === Define: openstack_h yper_v::python::windows_service
#
#  Define responsible of defining Windows services based on pyhtno code. It uses
#  win32service functionality to make it work.
#
# === Parameters
#
# [*name*]
#   Name of the service. Defaults to the title of the resource.
# [*display_name*]
#   Display name of the service. Defaults to the name of the service.
# [*description*]
#   A description of the service.
# [*start*]
#   The starting mode of the service. Valid values are the ones supported by 
#   sc.exe: boot, system, auto, demand, disabled, delayed-auto.
# [*arguments*]
#   String containing the arguments to pass to the python script.
# [*script*]
#   Python script that will be called by the service.
# == Examples
#
#  openstack_hyper_v::python::windows_service { 'nova-compute':
#    ensure      => present, 
#    description => 'OpenStack Nova compute service for Hyper-V',
#    start       => automatic,
#    arguments   => '--config-file=C:\OpenStack\etc\nova.conf',
#    script      => 'C:\OpenStack\scripts\NovaComputeWindowsService.NovaComputeWindowsService',
#  }
#
# == Authors
#
define openstack_hyper_v::python::windows_service (
  $display_name = $name,
  $description  = "",
  $start        = automatic,
  $arguments    = "",
  $ensure       = present,
  $script,
){

  exec { "create-python-${name}-windows-service":
    command  => "& sc.exe create ${name} binpath= \"C:\\Python27\\lib\\site-packages\\win32\\PythonService.exe ${arguments}\" start= ${start} DisplayName= \"${display_name}\" ",
    unless   => "exit @(Get-Service ${name}).Count -eq 0",
    provider => powershell,
  }

  registry_key { "HKLM\\System\\CurrentControlSet\\Services\\${name}\\PythonClass":
    ensure  => $ensure,
    require => Exec["create-python-${name}-windows-service"],
  }

  registry_key { "HKLM\\System\\CurrentControlSet\\Services\\${name}\\PythonClass":
    ensure  => $ensure,
    require => [Exec["create-python-${name}-windows-service"],
	            Registry_key["HKLM\\System\\CurrentControlSet\\Services\\${name}"],],
  }
  
  registry_value { "HKLM\\System\\CurrentControlSet\\Services\\${name}\\PythonClass\\":
    ensure  => $ensure,
    type    => string,
    data    => $script,
    require => Registry_key["HKLM\\System\\CurrentControlSet\\Services\\${name}\\PythonClass"],
  }
}
