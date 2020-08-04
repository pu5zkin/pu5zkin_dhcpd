#
# Cookbook:: pu5zkin_dhcpd
# Spec:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'pu5zkin_dhcpd::default' do
  context 'When all attributes are default, on Ubuntu 20.04' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'centos', '7.7.1908'

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'Creates /etc/sysconfig/network-scripts/ifcfg-eth1 file' do
      expect(chef_run).to create_template('/etc/sysconfig/network-scripts/ifcfg-eth1').with(
        user: 'root',
        group: 'root',
        mode: '0644'
      )
    end

    it 'Creates /etc/dhcp/dhcpd.conf' do
      expect(chef_run).to create_template('/etc/dhcp/dhcpd.conf').with(
        user: 'root',
        group: 'root',
        mode: '0644'
      )
    end

    it 'Package is installed' do
      expect(chef_run).to install_package('dhcp')
    end

    it 'Service is enabled' do
      expect(chef_run).to enable_service('dhcpd')
    end

    it 'Service is running' do
      expect(chef_run).to start_service('dhcpd')
    end
  end
end
