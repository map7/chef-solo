
# Used by other recipes
ohai "ruby" do
  action :nothing
end

case node[:ruby_installer][:method]
when 'package'
  include_recipe 'ruby_installer::package'
when 'ree'
  include_recipe 'ruby_installer::ree'
when 'source'
  include_recipe 'ruby_installer::source'
else
  Chef::Log.error "[ruby_installer]: Unknown installation method requested (#{node[:ruby_installer][:method]})"
  raise "Unknown ruby installation method requested"
end

