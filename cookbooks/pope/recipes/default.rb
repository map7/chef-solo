include_recipe "apache2"
include_recipe "postgresql::server"

# --- Install packages we need ---
package 'sysstat'
package 'htop'
package 'screen'
package 'apt-file'
package 'command-not-found'
package 'nodejs'

# --- Install Rails
gem_package "rails" do
  action :install
end

# --- Setup Apache2
# The passenger-apache cookbook has compiled the library all you need to do is 
# include the lines in your httpd.conf file.
# 
# Your rails app should be put into /srv/<your app> and be linked into /var/www
file "/etc/apache2/mods-enabled/phusion.load" do
  owner "root"
  group "root"
  mode "0644"
  action :create
  content "
LoadModule passenger_module /usr/local/lib/ruby/gems/1.9.1/gems/passenger-3.0.7/ext/apache2/mod_passenger.so
PassengerRoot /usr/local/lib/ruby/gems/1.9.1/gems/passenger-3.0.7
PassengerRuby /usr/local/bin/ruby
"
end

file "/etc/apache2/sites-enabled/000-default" do
  action :delete
end

file "/etc/apache2/sites-enabled/rails_project" do
  owner "root"
  group "root"
  mode "0644"
  action :create
  content "
#
# Single project
#
# <VirtualHost *:80>
#    ServerName localhost / domain
#    DocumentRoot /srv/<app>    # <-- be sure to point to 'public'!
#    <Directory /srv/<app>>
#       AllowOverride all              # <-- relax Apache security settings
#       Options -MultiViews            # <-- MultiViews must be turned off
#    </Directory>
# </VirtualHost>
#
# Multiple projects 
#
# Link your app from /srv/<app>/current/public to /var/www/<app>
# EG: ln -s /srv/pub.co/current/public /var/www/pub.co
#
# <VirtualHost *:80>
#         ServerName localhost
#         DocumentRoot /var/www
#         RailsBaseURI /<app1>
#         RailsBaseURI /<app2>
#         RailsBaseURI /<app3>
# </VirtualHost>

"
end

# Setup permissions on deployment area.
execute "Add #{node[:dbuser]} to group www-data" do
  command "usermod -a -G www-data #{node[:dbuser]}"
end

execute "Change group on /srv" do 
  command "chown -R root:www-data /srv"
end

execute "Change permissions on /srv" do
  command "chmod -R 775 /srv"
end

# Setup gem sources
# execute "Add gem sources" do
#   command "gem sources -a http://gems.github.com"
#   not_if "gem sources -l | grep http://gems.github.com"
# end


# Setup postgres user
# sudo -u postgres createuser -sw map7
# Set dbuser in your solo.json file.
execute "create-database-user" do
  code = <<-EOH
sudo -u postgres psql -c "select * from pg_user where usename='#{node[:dbuser]}'" | grep -c #{node[:dbuser]}
EOH
#  command "sudo -u postgres createuser -sw #{node[:dbuser]}"
  command "sudo -u postgres psql -c \"create user #{node[:dbuser]} with password '#{node[:dbpass]}' createdb createuser\";"
  not_if code 
end

# Install sphinx search
package 'sphinxsearch'

execute "Copy sphinx config file" do
  command "cp /etc/sphinxsearch/sphinx.conf.sample /etc/sphinxsearch/sphinx.conf"
  not_if do
    File.exists?("/etc/sphinxsearch/sphinx.conf")
  end
end

# Install nokogiri requirements
package 'libxslt1-dev'
package 'libxml2-dev'

# Install ruby-debug
# gem_package "ruby-debug19" do
#   action :install
# end

# Install readline
# execute "Install readline" do
#   command "cd $rvm_path/src/$(rvm tools strings)/ext/readline;sudo ruby extconf.rb; sudo make; sudo make install"
# end

# RefineryCMS requirements
package "imagemagick"
