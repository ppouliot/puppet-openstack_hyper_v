# Define: windows::disable_windows_feature
#
# This module downloads then installs Visual C++
#
# Parameters: none
#
# Actions:
#

define windows::disable_windows_feature {
  exec { "RemoveWindowsFeature_${name}":
    path    => $::path,
    command => "powershell.exe -executionpolicy remotesigned -Command Remove-WindowsFeature ${name}",
  }
}
