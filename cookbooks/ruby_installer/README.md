RubyInstaller
=============

This cookbook provides Ruby installation from a variety of places. It also
handles ohai reloading to ensure proper ruby/gem usage.

Usage
=====

```
knife node run_list add my.node recipe[ruby_installer]
```

By default it will install ruby packages and generally defaults to 1.8. You
can override that by providing the package names you want installed via
attributes.

Configurable attributes
=======================

* `default[:ruby_installer][:method] = 'package' # package/ree/source
* `default[:ruby_installer][:package_name] = true # apt package name`
* `default[:ruby_installer][:rubygem_package] = true # install rubygems package`
* `default[:ruby_installer][:rubydev_package] = true # install ruby development libs`
* `default[:ruby_installer][:source_version] = nil # source version`
* `default[:ruby_installer][:source_package_dependencies] = [] # package dependencies for building from source`
* `default[:ruby_installer][:ree_url] = 'http://rubyenterpriseedition.googlecode.com/files/ruby-enterprise_1.8.7-2012.02_amd64_ubuntu10.04.deb' # URI for REE deb package`
* `default[:ruby_installer][:ree_source_url] = 'http://rubyenterpriseedition.googlecode.com/files/ruby-enterprise-1.8.7-2012.02.tar.gz' # URI for REE source`

Repository
==========

https://github.com/heavywater/chef-ruby_installer

Contributors
============

* Graham McIntire - https://github.com/gmcintire
