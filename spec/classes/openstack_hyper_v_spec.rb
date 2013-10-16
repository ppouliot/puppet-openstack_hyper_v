require 'spec_helper'

describe 'openstack_hyper_v', :type => :class do

  context "On Windows platforms" do

    let :facts do
      {
        :osfamily => 'windows'
      }
    end

    it {
      should contain_service('nova-compute').with( { 'ensure' => 'running' } )
    }
  end

  context "On Windows platforms with a Virtual Switch name specified" do
    let :params do
      {
        :virtual_switch_name => 'virtual_switch_name'
      }
    end

    let :facts do
      {
        :osfamily => 'windows'
      }
    end

    it { 
      should contain_virtual_switch('virtual_switch_name').with( {'name' => 'virtual_switch_name'} )
    }
  end

  context "On an unsupported OS" do

    let :facts do
      {
        :osfamily => 'linux'
      }
    end

    it {
      expect { should raise_error(Puppet::Error) }
    }
  end
end
