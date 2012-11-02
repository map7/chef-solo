include_recipe 'build-essential'

Array(node[:ruby_installer][:source_package_dependencies]).each do |pkg|
  package pkg
end

bash "install_ruby" do
  cwd "/usr/src"
  code <<-EOH
    tar -zxf ruby-#{node[:ruby_installer][:source_version]}.tar.gz
    cd ruby-#{node[:ruby_installer][:source_version]}/
    autoconf
    ./configure --prefix=#{node[:ruby_installer][:source_install_dir]} --disable-instal-doc --enable-shared
    make -j#{node[:cpu][:total]+1}
    make install
  EOH
  action :nothing
  notifies :reload, resources(:ohai => 'ruby'), :immediately
end

remote_file "/usr/src/ruby-#{node[:ruby_installer][:source_version]}.tar.gz" do
  not_if do
    begin
      v = %{#{File.join(node[:ruby_installer][:source_install_dir], 'bin', 'ruby')} --version}.strip
      v.split(' ')[1] == node[:ruby_installer][:source_version].sub('-', '')
    rescue Errno::ENOENT
      false
    end
  end
  source "http://ftp.ruby-lang.org/pub/ruby/#{node[:ruby_installer][:source_version][0..2]}/ruby-#{node[:ruby_installer][:source_version]}.tar.gz"
  action :create_if_missing
  notifies :run, "bash[install_ruby]", :immediately
end

rin_ver = Gem::Version.new(node[:ruby_installer][:source_version].match(/(\d+\.?){2,3}/).to_s)

if(rin_ver < Gem::Version.new('1.9.0') || node[:ruby_installer][:source_rubygems_force])
  include_recipe 'ruby_installer::source_rubygems'
end
