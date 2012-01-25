# Mythtv Server LTSP Setup
#
#
home = ENV['HOME']
user = ENV['SUDO_USER']

package 'dhcp3-server'
package 'tftp'

# Copy diskless readme
cookbook_file "/home/mythserver/Desktop/diskless_readme.txt" do
  source "diskless_readme.txt"
  owner "mythserver"
  group "mythserver"
end

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

# Install diskess server
package 'mythbuntu-diskless-server'

execute "Create diskless image" do
  command 'ltsp-build-client --mythbuntu --mythbuntu-user-credentials "mythclient":"mythclient" --copy-package-lists --copy-sourceslist --accept-unsigned-packages --arch i386'
  action :run
  not_if {File.exists?("/opt/ltsp/i386")}
end

# Add ltsp_chroot
cookbook_file "#{home}/bin/ltsp_chroot" do
  source "scripts/ltsp_chroot"
  backup 2
  mode "0755"
  owner user
  group user  
end
