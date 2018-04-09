#
# Cookbook:: web-server
# Recipe:: server
#
# Copyright:: 2018, The Authors, All Rights Reserved.
#
package 'httpd' do
   action :install
end

file '/var/www/html/index.html' do
   content "<h1>Hello world from chef</h1>
   <b>HOSTNAME: </b>  #{node['hostname']}
   <b>IPADDRESS: </b> #{node['ipaddress']}
"
   action :create
end

service 'httpd' do
   action [ :enable, :start ]
end
