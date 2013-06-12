# Class: windows::google_chrome
#
# This module downloads then installs the Google Chrome Web Browser
#
# Parameters: none
#
# Actions:
#


class windows::tools::google_chrome {

  $chrome_url = 'https://dl.google.com/tag/s/appguid%3D%7B8A69D345-D564-463C-AFF1-A69D9E530F96%7D%26iid%3D%7B6414C132-7FB2-4B3F-A9F2-AC9E014598BE%7D%26lang%3Den%26browser%3D4%26usagestats%3D0%26appname%3DGoogle%2520Chrome%26needsadmin%3Dtrue/edgedl/chrome/install/GoogleChromeStandaloneEnterprise.msi'
  $chrome_file = 'GoogleChromeStandaloneEnterprise.msi'


  commands::download{'GoogleChrome':
    url  => $chrome_url,
    file => $chrome_file,
  }

  package { 'Google Chrome':
    ensure          => installed,
    source          => "${::temp}\\${chrome_file}",
    install_options => ['/PASSIVE',],
    require         => Commands::Download['GoogleChrome'],
  }

}

