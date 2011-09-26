# --- Install packages we need ---
package 'sysstat'
package 'htop'
package 'screen'

# --- Install Rails
gem_package "rails" do
  action :install
end
