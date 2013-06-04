# Class: windows
#
# This module contains basic configuration tasks for
# building windows compute nodes for openstack
#
# Parameters: none
#
# Actions:
#


class windows {

  dism { 'Microsoft-Hyper-V':
    ensure => present,
  }

  dism { 'Microsoft-Hyper-V-Management-Clients':
    ensure => present,
  }

  dism { 'Microsoft-Hyper-V-Management-PowerShell':
    ensure => present,
  }

  $winpath         = "${::systemroot}\\sysnative;c:\\winpe\\bin;${::path}"
  $powershell_path = "${::systemroot}\\sysnative\\WindowsPowerShell\\v1.0"
  $path            = "${winpath};${powershell_path};${::path}"
  #Default Time Source and Zone
  #$timeserver = 'bonehed.lcs.mit.edu'
  #$timezone   = 'Eastern Standard Time'
  Exec{
    path => "${powershell_path};${winpath};${::path}",
  }
  class { 'windows::commands': }
  class { 'windows::ntp': }
  class { 'windows::disable_firewalls': }
  class { 'windows::enable_auto_update': }
  class { 'windows::7zip': }
  class { 'windows::rdp': }
  class { 'windows::vexasoftcmdlet': }
  class { 'windows::git': }
  # Optional
  class { 'windows::java': }
  class { 'windows::notepadplusplus': }
  class { 'windows::google_chrome': }
  #class {' windows::visualcplusplus2010': }
  #class { 'windows::visualcplusplus2012': }
  class { 'windows::freerdp': }
  #class {'windows::cloudbase': }
  class { 'windows::python': }
  class { 'windows::python_m2crypto': }
  #class { 'windows::python-mysql': }
  #class { 'windows::pywin32': }
  #class { 'windows::easyinstall': }

}
