case node[:platform]
when "ubuntu"
include_recipe "postgresql::client_debian"
end
