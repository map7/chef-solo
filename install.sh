#!/bin/bash

# This runs as root on the server
chef_binary=/var/lib/gems/1.9.1/bin/chef-solo

# Are we on a vanilla system?
if ! test -f "$chef_binary"; then

     export DEBIAN_FRONTEND=noninteractive
     # Upgrade headlessly (this is only safe-ish on vanilla systems)
     aptitude update
     apt-get -o Dpkg::Options::="--force-confnew" \
         --force-yes -fuy dist-upgrade


    # # Install RVM - I don't think this should be done in the bootstrap.
    # aptitude install -y install curl git-core
    # bash < <(curl -s https://rvm.beginrescueend.com/install/rvm)

    # rvm_include_string='[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"'
    # grep "$rvm_include_string" ~/.bashrc || echo "$rvm_include_string" >> ~/.bashrc

    # rvm_bin="$HOME/.rvm/scripts/rvm"

    # # Install Ruby and Chef
    # "$rvm_bin" install 1.9.2

    
    aptitude install -y ruby1.9.1 ruby1.9.1-dev make rubygems1.9.1 libopenssl-ruby1.9.1 
    sudo gem1.9.1 install --no-rdoc --no-ri chef --version 0.10.0

fi

"$chef_binary" -c solo.rb -j solo.json
