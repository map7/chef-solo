bash 'install_rubygems' do
  cwd "/usr/src"
  code <<-EOH
    tar -zxf rubygems-#{node[:ruby_installer][:source_rubygems_version]}.tgz
    cd rubygems-#{node[:ruby_installer][:source_rubygems_version]}
    #{File.join(node[:ruby_installer][:source_install_dir], 'bin', 'ruby')} setup.rb
  EOH
  action :nothing
end

remote_file "/usr/src/rubygems-#{node[:ruby_installer][:source_rubygems_version]}.tgz" do
  source "http://production.cf.rubygems.org/rubygems/rubygems-#{node[:ruby_installer][:source_rubygems_version]}.tgz"
  not_if do
    begin
      v = %x{#{File.join(node[:ruby_installer][:source_install_dir], 'bin', 'gem')} --version}.strip
      v == node[:ruby_installer][:source_rubygems_version]
    rescue Errno::ENOENT
      false
    end
  end
  action :create_if_missing
  notifies :run, 'bash[install_rubygems]', :immediately
end
