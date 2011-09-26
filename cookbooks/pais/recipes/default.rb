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
#     ServerName www.yourhost.com
#     DocumentRoot /somewhere/public    # <-- be sure to point to 'public'!
#     <Directory /somewhere/public>
#        AllowOverride all              # <-- relax Apache security settings
#        Options -MultiViews            # <-- MultiViews must be turned off
#     </Directory>
#  </VirtualHost>
"
end


