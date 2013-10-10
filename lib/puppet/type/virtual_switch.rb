Puppet::Type.newtype(:virtual_switch) do  
  @doc = <<-'EOT'
    Manages Microsoft Hyper-V virtual switches, including their parameters.

    The `virtual_switch` type can manage the three options available in Hyper-V: Internal,
    Private, and External switches. All these types share three parameters: `name, `notes` and
    `type`. The External type adds two more options: the `os_managed`, responsible of allow the
    management OS share the interface, and `interface_address`, containing the IP address of the
    host that will be bound to the switch.

    Sample usage:

      virtual_switch { 'test_net':
        notes             => 'Switch bound to main address fact',
        type              => External,
	os_managed        => true,
	interface_address => $::ipaddress,
      }

      virtual_switch { 'mio2':    
        notes => 'private switch',
        type  => Private,
      }
  EOT

  ensurable

  newparam(:name, :namevar => true) do
    desc "The name of the virtual switch."
  end

  newproperty(:notes) do
    desc "Descriptive notes to be associated with the virtual switch in the hypervisor"
  end

  newproperty(:interface_address) do
    desc "IP address from one physical net adapter to bind the switch"
  end

  newproperty(:os_managed, :boolean => true) do
    desc "A property that allows the management OS to share the device"
  end

  newproperty(:type) do
    desc "A property that specifies the type of the switch to be defined"
    newvalues(:Internal, :External, :Private)
  end
end
