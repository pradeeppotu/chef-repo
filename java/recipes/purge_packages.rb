#
# Author:: Pradeep Kumar Potu (<pradeep.potu@harman.com>)
# Cookbook Name:: java
# Recipe:: purge_packages

%w[sun-java6-jdk sun-java6-bin sun-java6-jre].each do |pkg|
  package pkg do
    action :purge
  end
end
