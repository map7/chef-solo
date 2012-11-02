default[:ruby_installer][:method] = 'package'
default[:ruby_installer][:package_name] = true
default[:ruby_installer][:rubygem_package] = true
default[:ruby_installer][:rubydev_package] = true
default[:ruby_installer][:source_version] = '1.9.3-p194'
default[:ruby_installer][:source_install_dir] = '/usr/local'
default[:ruby_installer][:source_rubygems_version] = '1.8.24'
default[:ruby_installer][:source_rubygems_force] = false
default[:ruby_installer][:source_package_dependencies] = case node.platform_family
when 'debian'
  %w(
    openssl libreadline6 libreadline6-dev curl zlib1g zlib1g-dev libssl-dev
    libyaml-dev libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev
    automake libtool bison
  )
when 'rhel', 'fedora'
  %w(
    readline readline-devel zlib zlib-devl libyaml-devel libffi-devel openssl-devel
    bzip2 autoconf libtool bison iconv-devel
  )
else
  []
end
default[:ruby_installer][:ree_url] = 'http://rubyenterpriseedition.googlecode.com/files/ruby-enterprise_1.8.7-2012.02_amd64_ubuntu10.04.deb'
default[:ruby_installer][:ree_source_url] = 'http://rubyenterpriseedition.googlecode.com/files/ruby-enterprise-1.8.7-2012.02.tar.gz'
