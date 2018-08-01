#
# Cookbook Name:: arpconfig
# Recipe:: nessus_agent_install
#

agentDownloadDir = File.dirname(node['arpconfig']['nessus']['downloadLocation'])
agentPath = node['arpconfig']['nessus']['downloadLocation']
agentFileName = File.basename(node['arpconfig']['nessus']['downloadLocation'])

# Create the download directory 'recursively' if it does not exist
directory agentDownloadDir do
  action :create
  recursive true
  owner 'root'
  group 'root'
  mode '0755'
end

# download the file
s3_file agentPath do
  bucket node["arpconfig"]["nessus"]["digsecBucket"]
  remote_path node["arpconfig"]["nessus"]["agentPackageS3Path"]
  owner 'root'
  group 'root'
  mode '0755'
  action :create
  notifies :install, "package[#{agentFileName}]", :immediately
end

# Install Nessus Agent
package agentFileName do
  source File.join(agentDownloadDir, agentFileName)
  action :nothing
  notifies :run, "bash[Link Nessus Agent]", :immediately
end

# Link Nessus Agent to Manager
agentKey = node["arpconfig"]["nessus"]["agentKey"]
nessusMgrHost = node["arpconfig"]["nessus"]["managerHost"]
nessusMgrPort = node["arpconfig"]["nessus"]["managerPort"]
environment = node["arpconfig"]["nessus"]["environment"]
hostname = node['hostname']
bash "Link Nessus Agent" do
  cwd "/opt/nessus_agent/sbin/"
  code <<-EOH
  ./nessuscli agent link --key=#{agentKey} --host=#{nessusMgrHost} --port=#{nessusMgrPort} --name=#{environment}#{hostname}
  EOH
  action :nothing
  notifies :restart, "service[nessusagent]"
end

# Launch Service
service "nessusagent" do
  action :start
end