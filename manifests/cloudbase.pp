# Class: openstack_hyper_v::cloudbase
#
# This module downloads then installs the Cloudbase Solution Hyper-V OpenStack Installer
#
# Parameters: none
#
# Actions:
#

class openstack_hyper_v::cloudbase {
  $admin_pwd            = 'openstack'
  $devstack             = '10.21.7.51'
  $cb_url               = 'http://www.cloudbase.it/downloads'
  $compute_file         = 'HyperVNovaCompute_Grizzly.msi'
  $installdir           = 'C:\OpenStack\Nova'
  $sql                  = $devstack
  $sql_user             = 'admin'
  $sql_passwd           = $admin_pwd
  $nova_sql_connection  = "mysql://${sql_user}:${sql_passwd}@${sql}/nova"
  $glance               = $devstack
  $rabbit               = $devstack
  $rabbit_passwd        = $admin_pwd
  $instance_path        = 'C:\HyperV'
  $quantum              = '10.21.7.52'
  $quantum_admin        = 'admin'
  $quantum_admin_passwd = $::admin_passwd
  $vswitch_name         = 'openstack-br'
  $keystone             = $devstack

  commands::download{'cloudbase-nova-compute':
    url  => "${cb_url}/${compute_file}",
    file => $compute_file,
  }

  package { 'OpenStack Hyper-V Nova Compute 2013.1':
    ensure          => installed,
    source          => "${::temp}\\${compute_file}",
    install_options => ['ADDLOCAL=HyperVNovaCompute',
                        'QuantumHyperVAgent',
                        'iSCSISWInitiator',
                        'OpenStackCmdPrompt',
                        "INSTALLDIR=${installdir}",
                        "GLANCEHOST=${glance}",
                        'GLANCEPORT=9292',
                        "RABBITHOST=${rabbit}",
                        'RABBITPORT=5672',
                        "RABBITPASSWORD=${rabbit_passwd}",
                        "NOVASQLCONNECTION=${nova_sql_connection}",
                        'INSTANCESPATH=C:\HyperV',
                        'ADDVSWITCH=0',
                        'VSWITCHNAME=external1',
                        'LIMITCPUFEATURES=\”\'',
                        'USECOWIMAGES=1',
                        'LOGDIR=C:\log',
                        'ENABLELOGGING=1',
                        'VERBOSELOGGING=1',
                        "QUANTUMURL=http://${quantum}:9696",
                        'QUANTUMADMINTENANTNAME=service',
                        "QUANTUMADMINUSERNAME=${quantum_admin}",
                        "QUANTUMADMINPASSWORD=${quantum_admin_passwd}",
                        "QUANTUMADMINAUTHURL=http://${keystone}:35357/v2.0",],
    require         => Commands::Download['cloudbase-nova-compute'],
  }
}

