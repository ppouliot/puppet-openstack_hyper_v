$if = Get-NetIPAddress -IPAddress 169*| Get-NetIPInterface
	New-VMSwitch -NetAdapterName $if.ifAlias -Name openstack-br -AllowManagementOS $true
