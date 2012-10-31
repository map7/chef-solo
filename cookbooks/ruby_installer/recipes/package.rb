if(node[:ruby_installer][:package_name])
  if(node[:ruby_installer][:package_name] == true)
    case node.platform_family
    when 'debian'
      package_name = 'ruby-full'
    when 'fedora', 'rhel'
      package_name = 'ruby'
    else
      raise 'Unknown package name for this platform'
    end
  else
    package_name = node[:ruby_installer][:package_name]
  end
end

if(node[:ruby_installer][:rubydev_package])
  if(node[:ruby_installer][:rubydev_package] == true)
    case node.platform_family
    when 'debian'
      dev_name = 'ruby-dev'
    when 'fedora', 'rhel'
      dev_name = 'ruby-devel'
    else
      raise 'Unknown ruby dev package name for this platform'
    end
  else
    dev_name = node[:ruby_installer][:rubydev_package]
  end
end

if(node[:ruby_installer][:rubygem_package])
  if(node[:ruby_installer][:rubygem_package] == true)
    case node.platform_family
    when 'debian'
      gem_name = 'rubygems'
    when 'fedora', 'rhel'
      gem_name = nil
    else
      raise 'Unknown rubygems package name for this platform'
    end
  else
    gem_name = node[:ruby_installer][:rubygem_package]
  end
end

[package_name, dev_name, gem_name].compact.each do |pkg|
  package pkg do
    action :upgrade
    notifies :reload, resources(:ohai => 'ruby'), :immediately
  end
end
