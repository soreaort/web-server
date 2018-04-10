#
# Cookbook:: web-server
# Recipe:: server
#
# Copyright:: 2018, The Authors, All Rights Reserved.
#
package 'httpd' do
   action :install
end

cookbook_file '/var/www/html/about.html' do
   source "about.html"
   action :create
end

template '/var/www/html/index.html' do
   source "index.html.erb"
   action :create
end

service 'httpd' do
   action [ :enable, :start ]
end
