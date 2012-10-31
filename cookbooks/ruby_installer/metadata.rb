maintainer       "Chris Roberts"
maintainer_email "chrisroberts.code@gmail.com"
license          "Apache 2.0"
description      "Installs ruby"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

%w(oracle centos redhat scientific enterpriseenterprise fedora amazon ubuntu debian mint).each do |os|
  supports os
end

depends 'build-essential'
