#
# Cookbook:: hostname
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

execute 'Configure hostname2' do
  command "echo #{node['opsworks']['instance']['hostname']}.#{node['opsworks']['stack']['name']}.#{node['domain_name']} > /etc/hostname"
  ignore_failure true
end
