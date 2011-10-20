# Mythtv Server setup
#
# Currently this assumes you are:
# - Running Mythbuntu 11.04 or greater.
# - Using a MCE compatible remote.
# - Live in Australia (shepherd EPG)
#
home = ENV['HOME']
user = ENV['SUDO_USER']

# Install system tools
package 'sysstat'
package 'htop'
package 'screen'
package 'apt-file'
package 'numlockx'

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

# Copy shepherd
cookbook_file "#{home}/bin/shepherd" do
  source "scripts/shepherd"
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

script "Update pacakges" do
  interpreter "bash"
  code <<-EOH
  apt-get update -o Acquire::http::No-Cache=True
  apt-get -o Dpkg::Options::="--force-confnew" \
          --force-yes -fuy dist-upgrade
  EOH
end

