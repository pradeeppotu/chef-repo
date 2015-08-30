#
# Author:: Pradeep Kumar Potu (<pradeep.potu@harman.com>)
# Cookbook Name:: java
# Recipe:: oracle

include_recipe "java::set_attributes_from_version"
include_recipe "java::#{node['java']['install_flavor']}"
