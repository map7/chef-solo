# Mythtv Server LTSP Setup
#
#

package 'dhcp3-server'
package 'tftp'

# Static IP settings
cookbook_file "/etc/network/interfaces" do
  source "network/interfaces"
  backup 5
  owner "root"
  group "root"
end

# DHCP settings
cookbook_file "/etc/dhcp/dhcpd.conf" do
  source "dhcp/dhcpd.conf"
  backup 5
  owner "root"
  group "root"
end
