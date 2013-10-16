# == Define: openstack_hyper_v::base::windows_feature
#
# It allows the extraction of compressed files.
#
# === Parameters
#
# [*file*]
#   The full path of the file
# [*destination*]
#   The destination path of the extracted items
#
# === Examples
#
#  openstack_hyper_v::base::extract_file { 'Hyper-V':
#    $file        => '',
#    $destination => '', 
#  }
#
# === Authors
#
# === Copyright
#
define openstack_hyper_v::base::extract_file($file, $destination){
  if !defined(Windows_common::Remote_file['7zip-msi-installer']) {
    windows_common::remote_file { '7zip-msi-installer':
      source      => 'http://dl.7-zip.org/7z930-x64.msi',
      destination => "${::temp}\\7z930-x64.msi",
    }
  }

  if !defined(Package['7-Zip 9.30 (x64 edition)']) {
    package { '7-Zip 9.30 (x64 edition)':
      ensure  => installed,
      source  => "${::temp}\\7z930-x64.msi",
      require => Windows_common::Remote_file['7zip-msi-installer']
    }
  }

  exec {"extract-file-${file}-to-${destination}":
    command     => "7z.exe x -y \"${file}\"",
    path        => "${programw6432}\\7-Zip;${::path}",
    cwd         => $destination,
    refreshonly => true,
    require     => Package['7-Zip 9.30 (x64 edition)'],
  }
}
