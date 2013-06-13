# Class: openstack-hyper-v::pip
#
# This module uses easy_install.exe to install python pip
#
# Parameters: none
#
# Actions:
#
class openstack-hyper-v::python::pip {

    exec { 'easy_install_pip':
        command   => 'C:\\Python27\\Scripts\\easy_install.exe pip',
        require   => Class ['openstack-hyper-v::python', 'openstack-hyper-v::python::easyinstall'],
    }

}

