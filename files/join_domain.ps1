$domain = "openstack.pouliot.net"
$user = "administrator" 
$pass = ConvertTo-SecureString "P@ssw0rd" -AsPlainText -Force 
$DomainCredential = New-Object System.Management.Automation.PSCredential $domain\$user, $pass 
Add-Computer -DomainName $domain -credential $DomainCredential
