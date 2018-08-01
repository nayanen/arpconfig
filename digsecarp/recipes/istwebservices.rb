#
# Cookbook Name:: digsecarp
# Recipe:: istwebservices
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "digsecarp::sslSetup" 

certfilePath = node['digsecarp']['certFilePath']
certKeyPath = node['digsecarp']['certKeyPath']

web_app "istwebservices" do
	template "sites/istwebservices.conf.erb"
	webservicednsname node['digsecarp']['webservicednsname']
	sslCert certfilePath
	sslKey certKeyPath
	elb_webservices node['digsecarp']['elb_webservices']
end