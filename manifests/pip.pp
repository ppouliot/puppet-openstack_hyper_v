# Class: windows::pip
#
# This module uses easy_install.exe to install python pip
#
# Parameters: none
#
# Actions:
#
class windows::pip {

    exec { 'easy_install_pip':
        command   => 'C:\\Python27\\Scripts\\easy_install.exe pip',
        require   => Class ['windows::python', 'windows::easyinstall'],
    }

}

