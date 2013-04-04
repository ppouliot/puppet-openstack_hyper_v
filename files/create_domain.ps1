
$safe_mode_passwd = ConvertTo-SecureString "P@ssw0rd" -asplaintext -force
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
Install-ADDSForest -DomainName ad.openstack.tld. -InstallDNS -DomainMode Win8 -SafeModeAdministratorPassword $safe_mode_password
