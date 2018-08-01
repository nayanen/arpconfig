#
# Cookbook Name:: digsecarp
# Recipe:: sslSetup
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#include_recipe "arpconfig"

certfilePath = node['digsecarp']['certFilePath']
certKeyPath = node['digsecarp']['certKeyPath']

link "/etc/ssl/certs" do
	to "/etc/pki/tls/certs"
end

link "/etc/ssl/private" do
	to "/etc/pki/tls/private"
end

cookbook_file certfilePath do
	source "#{node['digsecarp']['basednsname']}.crt"
	mode '0644'
end

cookbook_file certKeyPath do
	source "#{node['digsecarp']['basednsname']}.key"
	mode '0600'
end