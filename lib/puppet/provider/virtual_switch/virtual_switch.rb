Puppet::Type.type(:virtual_switch).provide(:virtual_switch) do
  @doc = "Manages Windows virtual switches for latest Windows versions"

  confine    :operatingsystem => :windows
  defaultfor :operatingsystem => :windows

  POWERSHELL =
    if File.exists?("#{ENV['SYSTEMROOT']}\\sysnative\\WindowsPowershell\\v1.0\\powershell.exe")
      "#{ENV['SYSTEMROOT']}\\sysnative\\WindowsPowershell\\v1.0\\powershell.exe"
    elsif File.exists?("#{ENV['SYSTEMROOT']}\\system32\\WindowsPowershell\\v1.0\\powershell.exe")
      "#{ENV['SYSTEMROOT']}\\system32\\WindowsPowershell\\v1.0\\powershell.exe"
    else
      "powershell.exe"
    end

  commands :powershell => POWERSHELL

  def create
    if resource[:type] == :External
      get_adapter_script = %/$if = Get-NetIPAddress -IPAddress #{resource[:interface_address]} | Get-NetIPInterface/
      powershell(%/#{get_adapter_script}; New-VMSwitch -Name "#{resource[:name]}" -Notes "#{resource[:notes]}" -NetAdapterName $if.ifAlias -AllowManagementOS $#{resource[:os_managed]}/)
    else
      powershell(%/New-VMSwitch -SwitchType #{resource[:type]} -Name "#{resource[:name]}" -Notes "#{resource[:notes]}"/)
    end
  end

  def destroy
    powershell(%/Remove-VMSwitch "#{resource[:name]}" -Force/)
  end

  def exists?
    begin
      powershell(%/Get-VMSwitch "#{resource[:name]}"/)
      true
    rescue Puppet::ExecutionFailure => e
      false
    end
  end

  def type
    type = powershell(%/(Get-VMSwitch "#{resource[:name]}").SwitchType/)
    type =~/^(.*)/
    $1
  end
  def type=(value)
    if resource[:type] == :External
       set_external_switch(resource[:name], resource[:interface_address], resource[:os_managed])
    else
      powershell(%/Set-VMSwitch -Name "#{resource[:name]}" -SwitchType #{resource[:type]}/)
    end
  end

  def notes
    notes = powershell(%/(Get-VMSwitch "#{resource[:name]}").Notes/)
    notes =~ /^(.*)/
    $1
  end
  def notes=(value)
    powershell(%/Set-VMSwitch -Name "#{resource[:name]}" -Notes "#{resource[:notes]}"/)
  end

  def interface_address
    if resource[:type] == :External
      interface_address = powershell(%/(Get-NetIPAddress |where {(Get-NetAdapter |where {$_.MacAddress -eq (Get-NetAdapter -InterfaceDescription (Get-VMSwitch "#{resource[:name]}").NetAdapterInterfaceDescription).MacAddress}).ifIndex -contains $_.InterfaceIndex}).IPAddress/)
      if interface_address.include? resource[:interface_address]
        resource[:interface_address]
      else
        interface_address =~ /^(.*)/
        $1
      end
    else
      nil
    end
  end
  def interface_address=(value)
    if resource[:type] == :External
      set_external_switch(resource[:name], resource[:interface_address], resource[:os_managed])
    end
  end

  def os_managed
    os_managed = powershell(%/(Get-VMSwitch "#{resource[:name]}").AllowManagementOS/)
    os_managed =~ /^(.*)/
    case $1
    when 'True'
      true
    when 'False'
      false
    end
  end
  def os_managed=(value)
    if resource[:type] == :External
      powershell(%/Set-VMSwitch "#{resource[:name]}" -AllowManagementOS $#{resource[:os_managed]}/)
    end
  end

private
  def set_external_switch(name, address, managed)
    get_adapter_script = %/$if = Get-NetIPAddress -IPAddress #{address} | Get-NetIPInterface/
    powershell(%/#{get_adapter_script};Set-VMSwitch "#{resource[:name]}" -SwitchType External -NetAdapterName $if.ifAlias -AllowManagementOS $#{managed}"/) 
  end

end
