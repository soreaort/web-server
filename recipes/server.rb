#
# Cookbook:: web-server
# Recipe:: server
#
# Copyright:: 2018, The Authors, All Rights Reserved.
#

package 'lsof'

package 'httpd' do
   action :install
end

remote_file '/var/www/html/homer.png' do
   source "http://pngimg.com/uploads/simpsons/simpsons_PNG15.png"
end

cookbook_file '/var/www/html/about.html' do
   source "about.html"
   action :create
end

bash 'inline script' do
   user "root"
   code "mkdir -p /var/www/html/mysites && chown -R apache /var/www/html/mysites"
   not_if '[ -d /var/www/html/mysites ]'
end

execute 'inline script' do
   user "root"
   command <<-EOH
   mkdir -p /var/www/html/mysites2/ /
   chown -R apache /var/www/html/mysites2/
   EOH
   not_if '[ -d /var/www/html/mysites2 ]'
end

cookbook_file '/var/www/html/script.sh' do
   source "script.sh"
   owner "root"
   mode "755"
   action :create
end

execute 'run script' do
   user "root"
   command "/var/www/html/script.sh"
   not_if '[ -d /var/www/html/mysites3 ]'
end

template '/var/www/html/index.html' do
   source "index.html.erb"
   action :create
end

service 'httpd' do
   action [ :start, :enable ]
end
