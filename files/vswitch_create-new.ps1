New-VMSwitch -NetAdapterName (Get-NetIPAddress -IPAddress 10.99.99*| Get-NetIPInterface).ifAlias -Name openstack-br -AllowManagementOS $true
