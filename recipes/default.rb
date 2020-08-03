#
# Cookbook:: pu5zkin_dhcpd
# Recipe:: default
#
# Copyright:: 2020, Pu5zkin, All Rights Reserved.
package 'dhcp' do
  action :install
end

template '/etc/sysconfig/network-scripts/ifcfg-eth1' do
  source 'ifcfg-eth1.erb'
  variables(
      IP_interface: node['routers'],
      Netmask_interface: node['netmask']
    )
  mode '0644'
  owner 'root'
  group 'root'
  notifies :restart, 'service[network service]', :delayed
end

template '/etc/dhcp/dhcpd.conf' do
  source 'dhcpd.conf.erb'
  variables(
      dns_servers: node['domain-name-servers'],
      default_lease_time: node['default-lease-time'],
      max_lease_time: node['max-lease-time'],
      subnet: node['subnet'],
      netmask: node['netmask'],
      broadcast_address: node['broadcast-address'],
      domain_name: node['domain-name'],
      routers: node['routers'],
      host_name: node['host']['1']['name'],
      host_mac: node['host']['1']['MAC'],
      host_ip: node['host']['1']['IP']
    )
  mode '0644'
  owner 'root'
  group 'root'
  notifies :restart, 'service[dhcpd service]', :delayed
end

service 'network service' do
  service_name 'network'
  action [:enable, :start]
end

service 'dhcpd service' do
  service_name 'dhcpd'
  action [:enable, :start]
end
