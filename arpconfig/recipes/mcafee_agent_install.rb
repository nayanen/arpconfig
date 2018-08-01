#
# Cookbook Name:: arpconfig
# Recipe:: mcafee_agent_install
#

agent_download_dir = File.dirname(node['arpconfig']['mcafee']['downloadLocation'])
agent_path = node['arpconfig']['mcafee']['downloadLocation']
agent_file_name = File.basename(node['arpconfig']['mcafee']['downloadLocation'])

# Create the download directory 'recursively' if it does not exist
directory agent_download_dir do
  action :create
  recursive true
  owner 'root'
  group 'root'
  mode '0755'
end

# download the file
s3_file agent_path do
  bucket node['arpconfig']['mcafee']['digsecBucket']
  remote_path node['arpconfig']['mcafee']['agentPackageS3Path']
  owner 'root'
  group 'root'
  mode '0755'
  action :create
  notifies :run, 'bash[Install McAfee Agent]', :immediately
end

bash 'Install McAfee Agent' do
  cwd agent_download_dir
  code <<-EOH
  unzip #{agent_file_name}
  chmod a+x install.sh
  ./install.sh -i
  EOH
  action :nothing
end
