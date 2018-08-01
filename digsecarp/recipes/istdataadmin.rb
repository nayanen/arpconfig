#
# Cookbook Name:: digsecarp
# Recipe:: istdataadmin
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "digsecarp::sslSetup" 

certfilePath = node['digsecarp']['certFilePath']
certKeyPath = node['digsecarp']['certKeyPath']

web_app "istdataadmin" do
	template "sites/istdataadmin.conf.erb"
	data_admin_dns_name node['digsecarp']['data_admin_dns_name']
	sslCert certfilePath
	sslKey certKeyPath
	elb_data_admin node['digsecarp']['elb_data_admin']
end