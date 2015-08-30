default[:storm][:deploy][:user] = ::File.exists?("/home/vagrant") ? "vagrant" : "ec2-user"
default[:storm][:deploy][:group] = ::File.exists?("/home/vagrant") ? "vagrant" : "ec2-user"

default[:storm][:nimbus][:host] = "127.0.0.1"
#default[:storm][:supervisor][:hosts] = node[:opsworks][:instance][:sunjava2][:private_ip]

default[:storm][:nimbus][:childopts] = "-Xmx512m -Djava.net.preferIPv4Stack=true"

default[:storm][:supervisor][:childopts] = "-Xmx512m -Djava.net.preferIPv4Stack=true"
default[:storm][:supervisor][:workerports] = (6700..6706).to_a
default[:storm][:worker][:childopts] = "-Xmx512m -Djava.net.preferIPv4Stack=true"

default[:storm][:ui][:childopts] = "-Xmx512m -Djava.net.preferIPv4Stack=true"

default[:storm][:version] = "0.9.4"

