#
# Cookbook Name:: digsecarp
# Recipe:: istcertserver
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "digsecarp::sslSetup" 

certfilePath = node['digsecarp']['certFilePath']
certKeyPath = node['digsecarp']['certKeyPath']

web_app "istcertserver" do
	template "sites/istcertserver.conf.erb"
	certserverdnsname node['digsecarp']['cert_server_dns_name']
	sslCert certfilePath
	sslKey certKeyPath
	elb_certserver node['digsecarp']['elb_cert_server']
end