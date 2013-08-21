# === Define: openstack_h yper_v::python::windows_service
#
#  Define responsible of defining Windows services based on pyhtno code. It uses
#  win32service functionality to make it work.
#
# === Parameters
#
# [*ensure*]
# [*name*]
#   Name of the service. Defaults to the title of the resource.
# [*display_name*]
#   Display name of the service. Defaults to the name of the service.
# [*description*]
#   A description of the service.
# [*start*]
#   The starting mode of the service. Valid values are: automatic, manual,
#   disabled.
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
  $ensure       = present,
  $display_name = $name,
  $description  = "",
  $start        = automatic,
  $arguments    = "",
  $script,
){
  registry::service { $name:
    ensure       => $ensure,
    display_name => $display_name,
    start        => $start,
    description  => $description,
    command      => "C:\\Python27\\lib\\site-packages\\win32\\PythonService.exe ${arguments}",
  }

  registry_key { "HKLM\\System\\CurrentControlSet\\Services\\${name}\\PythonClass":
    ensure  => $ensure,
    require => Registry::Service[$name],
  }

  registry_value { "HKLM\\System\\CurrentControlSet\\Services\\${name}\\PythonClass\\":
    ensure  => $ensure,
    type    => string,
    data    => $script,
    require => Registry_key["HKLM\\System\\CurrentControlSet\\Services\\${name}\\PythonClass"],
  }

  exec {"${name}-service-creation-restart":
    command     => "shutdown.exe /r /t 0",
    path        => $::path,
    refreshonly => true,
    subscribe   => Registry::Service[$name]
  }
}
