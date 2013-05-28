# Class: windows::python_m2crypto
#
# This module downloads then installs the Python M2Crypto MSI
#
# Parameters: none
#
# Actions:
#

class windows::python_m2crypto{
  $m2crypto_url  = 'http://chandlerproject.org/pub/Projects/MeTooCrypto/M2Crypto-0.21.1.win32-py2.7.msi'
  $m2crypto_file = 'M2Crypto-0.21.1.win32-py2.7.msi'

  commands::download{'m2crypto.msi':
    url  => $m2crypto_url,
    file => $m2crypto_file,
  }

  package { 'Python 2.7 M2Crypto-0.21.1':
    ensure          => installed,
    source          => "${::temp}\\${m2crypto_file}",
    provider        => windows,
    install_options => '/PASSIVE',
    require         => [Commands::Download['m2crypto.msi'], Package['Python 2.7.3']],
  }
}
