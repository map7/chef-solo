#!/bin/bash

json="${1}"

logfile="/root/chef-solo.log"

# This runs as root on the server
chef_binary="/usr/local/bin/chef-solo"


# Are we on a vanilla system?
if ! test -f "$chef_binary"; then

     export DEBIAN_FRONTEND=noninteractive

     # Upgrade headlessly (this is only safe-ish on vanilla systems)
     # apt-get update -o Acquire::http::No-Cache=True
     # apt-get -o Dpkg::Options::="--force-confnew" --force-yes -fuy dist-upgrade

     apt-get install -y curl build-essential zlib1g-dev libssl-dev libreadline-gplv2-dev libyaml-dev git-core bzip2

	 # Download ruby 1.9.3-p125
	 cd /tmp
	 # wget ftp://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p125.tar.gz
	 # tar -xvzf ruby-1.9.3-p125.tar.gz

	 # Install
	 cd ruby-1.9.3-p125/
	 ./configure --prefix=/usr/local
	 make
	 make install
     
     # Install chef
     gem install chef ruby-shadow --no-rdoc --no-ri
fi

# Run chef-solo on server
"$chef_binary" --config solo.rb --json-attributes "$json"
