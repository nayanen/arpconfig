arpconfig Cookbook
==================

This cookbook configures a Linux Machine to act as an Authenticating Reverse Proxy (ARP) as per Philips IT CIOP ARP guidelines. 

This cookbook manages installation, configuration of Apache HTTP Server and also handles installation, configuration of Shibboleth on the ARP. 

This cookbook depends on Apache2 cookbook and can be distributed accross Philips projects to quickly and easily maintain ARP configuration. 

The cookbook does not need the full fledged Chef Server and can work with Chef Zero as well. This makes it useful on AWS OpsWorks.

Potential improvements to add are to implement the CIS Benchmarks for Linux into the cookbook. Currently the Over-The-Shelf CIS image for RHEl or AMZ Linux don't work well with Opsworks since there are some issues with giving right permissions to AWS Opsworks Agent. 