#
# Cookbook Name:: arpconfig
# Recipe:: default
#
# Copyright 2016, Philips Electronics
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'arpconfig::configure_proxy'
include_recipe 'supermarket_apache2'
include_recipe 'supermarket_apache2::mod_ssl'
include_recipe 'supermarket_apache2::mod_proxy'
include_recipe 'supermarket_apache2::mod_proxy_http'
include_recipe 'supermarket_apache2::mod_rewrite'
include_recipe 'supermarket_apache2::mod_deflate'
include_recipe 'supermarket_apache2::mod_headers'

include_recipe 'arpconfig::shibboleth'
