#!/bin/bash

role="${1}"

if [ -z "$role" ]; then
    role="solo.json"
fi

# This runs as root on the server
#chef_binary=/var/lib/gems/1.9.1/bin/chef-solo
chef_binary=/usr/bin/chef-solo

# Are we on a vanilla system?
if ! test -f "$chef_binary"; then

     export DEBIAN_FRONTEND=noninteractive
     # Upgrade headlessly (this is only safe-ish on vanilla systems)
     aptitude update
     apt-get -o Dpkg::Options::="--force-confnew" \
         --force-yes -fuy dist-upgrade
    
     # Install Ruby & Chef
     aptitude install -y ruby1.9.1 ruby1.9.1-dev make libopenssl-ruby1.9.1 

     # Install rubygems
     cd /tmp
     wget http://production.cf.rubygems.org/rubygems/rubygems-1.8.10.tgz
     tar zxf rubygems-1.8.10.tgz
     cd rubygems-1.8.10
     sudo ruby1.9.1 setup.rb --no-format-executable 

     sudo gem install --no-rdoc --no-ri chef --version 0.10.0
fi

"$chef_binary" --config solo.rb --json-attributes "$role"
