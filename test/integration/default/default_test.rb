# InSpec test for recipe pu5zkin_dhcpd::default

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/

unless os.windows?
  describe user('dhcp'), :skip do
    it { should exist }
  end
end

describe port(67), :skip do
  it { should_not be_listening }
end
