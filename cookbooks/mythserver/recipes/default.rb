# Mythtv Server setup
#
# Currently this assumes you are:
# - Running Mythbuntu 11.04 or greater.
# - Using a MCE compatible remote.
# - Live in Australia (shepherd EPG)
#

#
# Add resolv.conf
# Add packages: handbrake, ncdu, mplayer, rar
#
home = ENV['HOME']
user = ENV['SUDO_USER']

# Install system tools
package 'sysstat'
package 'htop'
package 'screen'
package 'apt-file'

package 'vim'
package 'zsh'
package 'fsarchiver'
package 'pbzip2'

# GUI tools
package 'catfish'
package 'xclip'
package 'gkrellm'
package 'gparted'
package 'gnome-do'
package 'ktorrent'

# numlockx
package 'numlockx'

directory "#{home}/.config/autostart" do
  recursive true  
end

cookbook_file "#{home}/.config/autostart/numlockx.desktop" do
  source "autostart/numlockx.desktop"
  mode "0755"
  owner user
  group user
end

# TV card firmware
package 'linux-firmware-nonfree'

# Mythtv
package 'mythtv-status'

# Install remote control packages
package 'irda-utils'
package 'xmacro'

cookbook_file "#{home}/.lirc/mythtv" do
  source "config/mythtv"
  backup 2
  mode "0644"
  owner user
  group user  
end

cookbook_file "#{home}/.lirc/irexec" do
  source "config/irexec"
  backup 2
  mode "0644"
  owner user
  group user  
end

service "lirc" do
  action :restart
end

# Shepherd requirements
%w[xmltv libxml-simple-perl libalgorithm-diff-perl libgetopt-mixed-perl libcompress-zlib-perl libdata-dumper-simple-perl libdate-manip-perl liblist-compare-perl libdatetime-format-strptime-perl libhtml-parser-perl libxml-dom-perl libgd-gd2-perl libdigest-sha1-perl libarchive-zip-perl libio-string-perl libdbi-perl].each do |pkg|
  package pkg do
    action :install
  end
end

# Create script directory within path
directory "#{home}/bin" do
  mode "0755"
  owner user
  group user
  action :create
end

# Copy shepherd
cookbook_file "#{home}/bin/shepherd" do
  source "scripts/shepherd"
  backup 2
  mode "0755"
  owner user
  group user  
end

# Custom scripts

# Copy find duplicates script across.
cookbook_file "#{home}/bin/finddups" do
  source "scripts/finddups"
  backup 2
  mode "0755"
  owner user
  group user  
end

# My equipment IR-blaster scripts
cookbook_file "#{home}/bin/myth_equipment" do
  source "scripts/myth_equipment"
  backup 2
  mode "0755"
  owner user
  group user  
end

# My restart mythfrontend script
cookbook_file "#{home}/bin/myth_start" do
  source "scripts/myth_start"
  backup 2
  mode "0755"
  owner user
  group user  
end

# Upgrade mythtv to the latest 0.24.x stable
cookbook_file "/etc/apt/sources.list.d/mythbuntu-repos.list" do
  source "config/mythbuntu-repos.list"
  backup 2
  mode "644"
  owner "root"
  group "root"
end

script "Update packages" do
  interpreter "bash"
  code <<-EOH
  apt-get update -o Acquire::http::No-Cache=True
  apt-get -o Dpkg::Options::="--force-confnew" --force-yes -fuy dist-upgrade
  EOH
end

# Samba
package "smbfs"
package "system-config-samba"

cookbook_file "/etc/samba/smb.conf" do
  source "config/smb.conf"
  backup 2
  mode "0644"
  owner "root"
  group "root"
end

service "smbd" do
  action :restart
end

# Setup storage mounts
directory "/storage1" do
  mode "755"
  owner user
  group user
end

directory "/storage2" do
  mode "755"
  owner user
  group user
end

directory "/storage3" do
  mode "755"
  owner user
  group user
end

# MythTV plugins
package "mythvideo" do
  options "--force-yes -y"
end
package "mythgallery" do
  options "--force-yes -y"
end
package "mythweather" do
  options "--force-yes -y"
end
package "mythgame" do
  options "--force-yes -y"
end
package "mythnews" do
  options "--force-yes -y"
end
package "mythnetvision" do
  options "--force-yes -y"
end
package "mythbrowser" do
  options "--force-yes -y"
end
package "mytharchive" do
  options "--force-yes -y"
end

# Mythmusic setup
package "mythmusic" do
  options "--force-yes -y"
end
package "libvisual-projectm"

# Mythtv fuse filesystem (Makes recordings show their names in file manager)
package "mythtvfs"

# Games

# Megadrive
package "dgen"
package "libsdl1.2-dev"

# Install tor for internet anonymity
# https://www.torproject.org/docs/tor-doc-unix.html.en
package 'tor'
