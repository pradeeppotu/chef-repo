name             'apache_zookeeper'
maintainer       'Pradeep Potu'
maintainer_email 'pradeep.potu@harman.com'
license          'All rights reserved'
description      'Installs/Configures Apache Zookeeper'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))

depends "java"

%w{ ubuntu centos }.each do |os|
  supports os
end

version          '0.2.1'
