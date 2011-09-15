# --- Install packages we need ---
package 'sysstat'
package 'htop'

# --- Install Rails
gem_package "rails" do
  action :install
end
