#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2022, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'nginx' do
    action [ :install ]
    options "--enablerepo=epel"
end

%w{
    nginx
    iptables
}.each do |svc|
    service svc do
      supports [ :restart, :reload ]
      action [ :enable, :start ]
    end
end

iptables_cons_path = '/etc/sysconfig/iptables'
allow_port = 80
execute "allow port #{allow_port}" do
    not_if "grep '-A INPUT -p tcp -m state --state NEW -m tcp --dport #{allow_port}' #{iptables_conf_path}"
    command "sed -i -e '/:OUTPUT ACCEPT/a-A INPUT -p tcp -m state --state NEW -m tcp --dport #{allow_port} -j ACCEPT' #{iptables_conf_path}"
    action :run
    notifies :restart, "service[iptables]"
end
