include_recipe "apache2"
include_recipe "postgresql::server"

# --- Install packages we need ---
package 'sysstat'
package 'htop'
package 'screen'

# --- Install Rails
gem_package "rails" do
  action :install
end

# --- Setup Apache2
# The passenger-apache cookbook has compiled the library all you need to do is 
# include the lines in your httpd.conf file.
# 
# Your rails app should be put into /var/www/<your app>
file "/etc/apache2/httpd.conf" do
  owner "root"
  group "root"
  mode "0644"
  backup 1
  action :create
  content "
LoadModule passenger_module /usr/local/rvm/gems/ruby-1.9.2-p290/gems/passenger-3.0.7/ext/apache2/mod_passenger.so
PassengerRoot /usr/local/rvm/gems/ruby-1.9.2-p290/gems/passenger-3.0.7
PassengerRuby /usr/local/rvm/wrappers/ruby-1.9.2-p290/ruby

#  <VirtualHost *:80>
#     ServerName www.yourhost.com / hostname
#     DocumentRoot /var/www/<app>/public    # <-- be sure to point to 'public'!
#     <Directory /var/www/<app>/public>
#        AllowOverride all              # <-- relax Apache security settings
#        Options -MultiViews            # <-- MultiViews must be turned off
#     </Directory>
#  </VirtualHost>
"
end

# Setup permissions on deployment area.
execute "Add #{node[:dbuser]} to group www-data" do
  command "usermod -a -G www-data #{node[:dbuser]}"
end

execute "Change group on /var/www" do 
  command "chown -R root:www-data /var/www"
end

execute "Change permissions on /var/www" do
  command "chmod -R 775 /var/www"
end


# Setup postgres user
# sudo -u postgres createuser -sw map7
# Set dbuser in your solo.json file.
execute "create-database-user" do
  code = <<-EOH
sudo -u postgres psql -c "select * from pg_user where usename='#{node[:dbuser]}'" | grep -c #{node[:dbuser]}
EOH
  command "sudo -u postgres createuser -sw #{node[:dbuser]}"
  not_if code 
end

# Install sphinx search
package 'sphinxsearch'
