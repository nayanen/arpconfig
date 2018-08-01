node.set['arpconfig']['entityid'] = case node['digsecarp']['environment']
    when 'tst' then 'https://IST-proxy.philips.com'
    when 'acc' then 'https://IST-proxy.acc.philips.com'
    when 'www' then 'https://IST-proxy.sso.philips.com'
	when 'dev' then 'https://IST-proxy.dev.philips.com'
  end

node.set['arpconfig']['idp_entityid'] = case node['digsecarp']['environment']
    when 'tst' then 'https://login.tst.sso.philips.com'
    when 'acc' then 'https://login.acc.sso.philips.com'
    when 'www' then 'https://login.sso.philips.com'
	when 'dev' then 'https://login.dev.philips.com'
  end

node.set['arpconfig']['local_metadata'] = case node['digsecarp']['environment']
    when 'tst' then ['metadata/tst.ist-proxy.philips.com.xml']
    when 'acc' then ['metadata/acc.ist-proxy.philips.com.xml']
    when 'www' then ['metadata/www.ist-proxy.philips.com.xml']
	when 'dev' then ['metadata/dev.ist-proxy.philips.com.xml']
  end


template "/etc/yum.repos.d/shibboleth.repo" do
	mode "0644"
	source "shibboleth.repo.erb"
end

yum_package 'shibboleth' do
  arch 'x86_64'
  action :install
end

directory '/etc/shibboleth/metadata' do
	owner 'root'
	group 'root'
	mode '0755'
	action :create
end

node["arpconfig"]["local_metadata"].each do |file|
  cookbook_file "/etc/shibboleth/#{file}" do
    source file
    mode "0644"
    notifies :restart, "service[shibd]"
  end
end

=begin
[
	"/etc/shibboleth/certificates",
	"/etc/shibboleth/certificates/certs",
	"/etc/shibboleth/certificates/keys"
].each do |dir|
	directory dir do
		owner node["arpconfig"]["user"]
		group node["arpconfig"]["user"]
		mode '0755'
		action :create
	end
end

cookbook_file "/etc/shibboleth/certificates/certs/sp.shibboleth-proxy.philips.com.pem" do
	source "sp.shibboleth-proxy.philips.com.crt"
    mode "0644"
    owner node["arpconfig"]["user"]
    group node["arpconfig"]["user"]
    notifies :restart, "service[shibd]"
end

cookbook_file "/etc/shibboleth/certificates/keys/sp.shibboleth-proxy.philips.com.pem" do
	source "sp.shibboleth-proxy.philips.com.key"
    mode "0644"
    owner node["arpconfig"]["user"]
    group node["arpconfig"]["user"]
    notifies :restart, "service[shibd]"
end
=end

if node["arpconfig"]["local_attribute_map"]
  cookbook_file "/etc/shibboleth/attribute-map.xml" do
    source "attribute-map.xml"
    mode "0644"
    notifies :restart, "service[shibd]"
  end
end

template "/etc/shibboleth/shibboleth2.xml" do
  mode "0644"
  variables(
    :entityid => node['arpconfig']['entityid'],
    :remote_user_attributes => node['arpconfig']['remote_user_attributes'],
    :idp_entityid => node['arpconfig']['idp_entityid'],
    :supportContact => node["arpconfig"]["support_contact"],
    :metadataFiles => node['arpconfig']['local_metadata']
  )
  notifies :restart, "service[shibd]"
end

apache_conf 'shib' do
	enable true
	cookbook "arpconfig"
end

apache_module "shib" do
	filename "mod_shib_22.so"
  identifier "mod_shib"
	module_path "/usr/lib64/shibboleth/mod_shib_22.so"
	conf false
end

service "shibd" do
  action [:enable, :start]
end