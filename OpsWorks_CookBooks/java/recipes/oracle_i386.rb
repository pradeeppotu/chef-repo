#
# Author:: Pradeep Kumar Potu (<pradeep.potu@harman.com>)
# Cookbook Name:: java
# Recipe:: oracle_i386

unless node.recipe?('java::default')
  Chef::Log.warn("Using java::default instead is recommended.")

# Even if this recipe is included by itself, a safety check is nice...
  if node['java']['java_home'].nil? or node['java']['java_home'].empty?
    include_recipe "java::set_attributes_from_version"
  end
end

java_home = node['java']["java_home"]

case node['java']['jdk_version'].to_s
when "6"
  tarball_url = node['java']['jdk']['6']['i586']['url']
  tarball_checksum = node['java']['jdk']['6']['i586']['checksum']
  bin_cmds = node['java']['jdk']['6']['bin_cmds']
when "7"
  tarball_url = node['java']['jdk']['7']['i586']['url']
  tarball_checksum = node['java']['jdk']['7']['i586']['checksum']
  bin_cmds = node['java']['jdk']['7']['bin_cmds']
when "8"
  tarball_url = node['java']['jdk']['8']['i586']['url']
  tarball_checksum = node['java']['jdk']['8']['i586']['checksum']
  bin_cmds = node['java']['jdk']['8']['bin_cmds']
end

include_recipe "java::set_java_home"

yum_package "glibc" do
  arch "i686"
  only_if { platform_family?( "rhel", "fedora" ) }
end

package "tar"

java_ark "jdk-alt" do
  url tarball_url
  default node['java']['set_default']
  checksum tarball_checksum
  app_home java_home
  bin_cmds bin_cmds
  retries node['java']['ark_retries']
  retry_delay node['java']['ark_retries']
  use_alt_suffix node['java']['use_alt_suffix']
  reset_alternatives node['java']['reset_alternatives']
  action :install
  default false
end

if node['java']['set_default'] and platform_family?('debian')
  include_recipe 'java::default_java_symlink'
end

include_recipe 'java::oracle_jce' if node['java']['oracle']['jce']['enabled']
