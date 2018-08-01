override['apache']['contact'] = 'ops@digsec.healthcare.philips.com'
override['apache']['default_modules'] = default['apache']['default_modules'] - ['status','autoindex']
override['apache']['mod_ssl']['protocol'] = 'All -SSLv2 -SSLv3 -TLSv1'
override['apache']['serversignature'] = 'Off'
override['apache']['listen_ports'] = ['80', '443']

default['arpconfig']['proxy']['proxy_url'] = 'http://internal-GLB-PROXY-elbIstWl-IOXQOSW6QYQS-1417289753.us-west-2.elb.amazonaws.com:8080'
