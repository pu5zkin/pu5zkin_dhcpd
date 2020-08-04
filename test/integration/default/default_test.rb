# InSpec test for recipe pu5zkin_dhcpd::default

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/

unless os.windows?
  describe user('dhcp'), :skip do
    it { should exist }
  end
end

describe file('/etc/dhcp/dhcpd.conf') do
  its('type') { should eq :file }
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }
  its('mode') { should cmp '0644' }
end

describe service('dhcpd') do
  it { should be_enabled }
  it { should be_running }
  it { should be_installed }
end

describe port(67) do
  it { should be_listening }
end
