# == Define: openstack_hyper_v::base::remote_file
#
# It downloads a remote file to a local path.
#
# === Parameters
#
# [*source*]
#   The remote location of the file. The current version only supports HTTP.
# [*destination*]
#   The full path on the local filesystem.
#
# === Examples
#
#  openstack_hyper_v::base::remote_file { 'my-remote-file':
#    source      => "http://192.168.1.1/remote_file.ext",
#    destination => 'C:\Folder\local_copy.ext',
#  }
#
# === Authors
#
# === Copyright
#
define openstack_hyper_v::base::remote_file($source, $destination){
  exec{ $name:
    command  => "(new-object Net.WebClient).DownloadFile(\'${source}\',\'${destination}\')",
    creates  => $destination,
    unless   => "exit !(Test-Path -Path '${destination}')",
    provider => powershell,
  }
}
