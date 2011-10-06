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

# Shepherd requirements
%w[xmltv libxml-simple-perl libalgorithm-diff-perl libgetopt-mixed-perl libcompress-zlib-perl libdata-dumper-simple-perl libdate-manip-perl liblist-compare-perl libdatetime-format-strptime-perl libhtml-parser-perl libxml-dom-perl libgd-gd2-perl libdigest-sha1-perl libarchive-zip-perl libio-string-perl libdbi-perl].each do |pkg|
  package pkg do
    action :install
  end
end

# # Setup postgres user
# # sudo -u postgres createuser -sw map7
# # Set dbuser in your solo.json file.
# execute "create-database-user" do
#   code = <<-EOH
# sudo -u postgres psql -c "select * from pg_user where usename='#{node[:dbuser]}'" | grep -c #{node[:dbuser]}
# EOH
# #  command "sudo -u postgres createuser -sw #{node[:dbuser]}"
#   command "sudo -u postgres psql -c \"create user #{node[:dbuser]} with password '#{node[:dbpass]}' createdb createuser\";"
#   not_if code 
# end

# # Install sphinx search
# package 'sphinxsearch'

# execute "Copy sphinx config file" do
#   command "cp /etc/sphinxsearch/sphinx.conf.dist /etc/sphinxsearch/sphinx.conf"
#   not_if do
#     File.exists?("/etc/sphinxsearch/sphinx.conf")
#   end
# end

# # Install nokogiri requirements
# package 'libxslt1-dev'
# package 'libxml2-dev'

# # Install ruby-debug
# # This has to be install like this if you run RVM system wide.
# execute "Install ruby-debug19" do 
#   command "gem install ruby-debug19 -- --with-ruby-include=$rvm_path/src/$(rvm tools strings)"
#   not_if "gem list | grep ruby-debug19"
# end

# # Install readline
# execute "Install readline" do
#   command "cd $rvm_path/src/$(rvm tools strings)/ext/readline;sudo ruby extconf.rb; sudo make; sudo make install"
# end

# # RefineryCMS requirements
# package "imagemagick"
