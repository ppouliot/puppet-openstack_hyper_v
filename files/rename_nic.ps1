$net=Get-NetAdapter|where-object {$_.Status -eq "Up"}
$name=$net[0].Name
&netsh interface set interface name="$name" newname="VSwitch0"
$name=$net[1].Name
&netsh interface set interface name="$name" newname="Mgmt0"

