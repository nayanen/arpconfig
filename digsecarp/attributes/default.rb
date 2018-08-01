default['digsecarp']['webservicesname'] = "webservices"
default['digsecarp']['certservername'] = "certserver"
default['digsecarp']['dataadminname'] = "admin"
default['digsecarp']['environment'] = "test"
default['digsecarp']['basednsname'] = "digsec.healthcare.philips.com"

default['digsecarp']['webservicednsname'] = "#{node['digsecarp']['environment']}.#{node['digsecarp']['webservicesname']}.#{node['digsecarp']['basednsname']}"
default['digsecarp']['elb_webservices'] = "internal-IST-TEST-elbISTWe-1XYWF6B41TZ7B-1523221804.us-west-2.elb.amazonaws.com"

default['digsecarp']['cert_server_dns_name'] = "#{node['digsecarp']['environment']}.#{node['digsecarp']['certservername']}.#{node['digsecarp']['basednsname']}"
default['digsecarp']['elb_cert_server'] = "internal-IST-TEST-elbISTCe-1BSC3918Y8ZTO-1782604445.us-west-2.elb.amazonaws.com"

default['digsecarp']['data_admin_dns_name'] = "#{node['digsecarp']['environment']}.#{node['digsecarp']['dataadminname']}.#{node['digsecarp']['basednsname']}"
default['digsecarp']['elb_data_admin'] = "internal-IST-TEST-elbISTDa-12LLC15N5AIPR-1215809914.us-west-2.elb.amazonaws.com"

default['digsecarp']['certFilePath'] = "/etc/ssl/certs/#{node['digsecarp']['basednsname']}.crt"
default['digsecarp']['certKeyPath'] = "/etc/ssl/private/#{node['digsecarp']['basednsname']}.key"
