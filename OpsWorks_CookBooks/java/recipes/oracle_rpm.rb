#
# Author:: Pradeep Kumar Potu (<pradeep.potu@harman.com>)
# Cookbook Name:: java
# Recipe:: oracle_rpm

include_recipe 'java::set_java_home'


slave_cmds = case node['java']['oracle_rpm']['type']
             when 'jdk'
               %W[appletviewer apt ControlPanel extcheck idlj jar jarsigner javac javadoc javafxpackager javah javap java-rmi.cgi javaws jcmd jconsole jcontrol jdb jhat jinfo jmap jps jrunscript jsadebugd jstack jstat jstatd jvisualvm keytool native2ascii orbd pack200 policytool rmic rmid rmiregistry schemagen serialver servertool tnameserv unpack200 wsgen wsimport xjc]

             when 'jre'
               %W[ControlPanel java_vm javaws jcontrol keytool orbd pack200 policytool rmid rmiregistry servertool tnameserv unpack200]

             else
               Chef::Application.fatal "Unsupported oracle RPM type (#{node['java']['oracle_rpm']['type']})"
             end

if platform_family?('rhel', 'fedora') and node['java']['set_default']

  bash 'update-java-alternatives' do
    java_home = node['java']['java_home']
    java_location = File.join(java_home, "bin", "java")
    slave_lines = slave_cmds.inject("") do |slaves, cmd|
      slaves << "--slave /usr/bin/#{cmd} #{cmd} #{File.join(java_home, "bin", cmd)} \\\n"
    end

    code <<-EOH.gsub(/^\s+/, '')
      update-alternatives --install /usr/bin/java java #{java_location} 1061 \
      #{slave_lines} && \
      update-alternatives --set java #{java_location}
    EOH
    action :nothing
  end

end

package_name = node['java']['oracle_rpm']['package_name'] || node['java']['oracle_rpm']['type']
package package_name  do
  action :install
  version node['java']['oracle_rpm']['package_version'] if node['java']['oracle_rpm']['package_version']
  notifies :run, 'bash[update-java-alternatives]', :immediately if platform_family?('rhel', 'fedora') and node['java']['set_default']
end

include_recipe 'java::oracle_jce' if node['java']['oracle']['jce']['enabled']
