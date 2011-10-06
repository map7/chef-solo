# Mythtv Server setup
#
# Currently this assumes you are:
# - Running Mythbuntu 11.04 or greater.
# - Using a MCE compatible remote.
# - Live in Australia (shepherd EPG)
#

# --- Install system tools
package 'sysstat'
package 'htop'
package 'screen'
package 'apt-file'

package 'vim'
package 'zsh'
package 'fsarchiver'

# --- GUI tools
package 'xclip'
package 'gkrellm'
package 'gparted'
package 'gnome-do'

# Install remote control packages
package 'irda-utils'
package 'xmacro'

cookbook_file "#{ENV['HOME']}/.lirc/mythtv" do
  source "mythtv"
  backup 2
  mode "0644"
end

# Shepherd requirements
%w[xmltv libxml-simple-perl libalgorithm-diff-perl libgetopt-mixed-perl libcompress-zlib-perl libdata-dumper-simple-perl libdate-manip-perl liblist-compare-perl libdatetime-format-strptime-perl libhtml-parser-perl libxml-dom-perl libgd-gd2-perl libdigest-sha1-perl libarchive-zip-perl libio-string-perl libdbi-perl].each do |pkg|
  package pkg do
    action :install
  end
end
