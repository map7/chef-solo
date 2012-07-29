# Mythtv Server LTSP Setup
#
#
home = ENV['HOME']
user = ENV['SUDO_USER']

package 'dhcp3-server'
package 'tftp'

# Copy diskless readme
cookbook_file "/home/#{user}/Desktop/diskless_readme.txt" do
  source "diskless_readme.txt"
  owner user
  group user
end

# Static IP settings
cookbook_file "/etc/network/interfaces" do
  source "network/interfaces"
  backup 5
  mode "0644"
  owner "root"
  group "root"
  not_if {node[:setup_dhcp] == "no"}
end

# DHCP settings
cookbook_file "/etc/dhcp/dhcpd.conf" do
  source "dhcp/dhcpd.conf"
  backup 5
  mode "0755"
  owner "root"
  group "root"
  not_if {node[:setup_dhcp] == "no"}
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

# Add overlay to exports
cookbook_file "/etc/exports" do
  source "network/exports"
  backup 2
  mode "0644"
  owner "root"
  group "root"
end

service "nfs-kernel-server" do
  action :restart
end
