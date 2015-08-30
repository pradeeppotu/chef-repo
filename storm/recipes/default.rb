#
# Cookbook Name:: storm-project
# Recipe:: default
#
#
#


#bash "Setup zookeeper as a daemon" do
#  code <<-EOH
#  sudo ln -s /usr/share/zookeeper/bin/zkServer.sh /etc/init.d/zookeeper
#  EOH
#  not_if do
#    ::File.exists?("/etc/init.d/zookeeper")
#  end
#end

#service "zookeeper" do
#  supports :status => true, :restart => true, :reload => true
#  action [ :enable, :start ]
#end

bash "Storm install" do
  user node[:storm][:deploy][:user]
  cwd "/home/#{node[:storm][:deploy][:user]}"
  code <<-EOH
  mkdir storm-data || true
#  wget 'http://apache.arvixe.com/storm/apache-storm-0.9.1-incubating/apache-storm-0.9.1-incubating.zip'
  wget 'http://apache.mirrors.lucidnetworks.net/storm/apache-storm-0.9.4/apache-storm-0.9.4.zip'
  unzip apache-storm-#{node[:storm][:version]}.zip
  cd apache-storm-#{node[:storm][:version]}
  EOH
  not_if do
    ::File.exists?("/home/#{node[:storm][:deploy][:user]}/apache-storm-#{node[:storm][:version]}")
  end
end
