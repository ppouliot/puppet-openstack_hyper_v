# Class: openstack_hyper_v::pip
#
# This module uses easy_install.exe to install python pip
#
# Parameters: none
#
# Actions:
#
class openstack_hyper_v::python::pip {

    exec { 'easy_install_pip':
        command   => 'C:\\Python27\\Scripts\\easy_install.exe pip',
        require   => Class ['openstack_hyper_v::python', 'openstack_hyper_v::python::easyinstall'],
    }

}

