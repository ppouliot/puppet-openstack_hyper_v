# Class: openstack-hyper-v::git
#
# This module downloads then installs Git for windows
#
# Parameters: none
#
# Actions:
#


class openstack-hyper-v::tools::git{
  $git_url  = 'http://cloud.github.com/downloads/msysgit/git/Git-1.8.0-preview20121022.exe'
  $git_file = 'Git-1.8.0-preview20121022.exe'

  commands::download{'Git':
    url  => $git_url,
    file => $git_file,
  }

  package { 'Git version 1.8.0-preview201221022':
    ensure          => installed,
    source          => "${::temp}\\${git_file}",
    install_options => ['/VERYSILENT','/SUPPRESSMSGBOXES','/LOG'],
    require         => Commands::Download['Git']
  }

}
