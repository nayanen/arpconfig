#
# Cookbook Name:: arpconfig
# Recipe:: configure_proxy
#

proxy_url = node['arpconfig']['proxy']['proxy_url']

template '/etc/environment' do
  mode '0644'
  source 'environment.erb'
  variables(
    proxyUrl: proxy_url
  )
  action :create
end

template '/etc/profile.d/proxy.sh' do
  mode '0644'
  source 'environment.erb'
  variables(
    proxyUrl: proxy_url
  )
  action :create
end

# Set the proxy value in the yum.conf file
proxy_entry = "proxy=#{proxy_url}"
yum_conf = Chef::Util::FileEdit.new('/etc/yum.conf')
yum_conf.search_file_delete_line(/proxy=/)
yum_conf.insert_line_if_no_match(/#{proxy_entry}/, proxy_entry)
yum_conf.write_file
