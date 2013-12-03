#
# Cookbook Name:: apache2
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

 package 'apache2' do
   action :nothing
  
 end
 
 package 'unzip' do
   
 end
 
 cookbook_file '/var/www/site.zip' do
    source 'site.zip'
    mode   '0755'
    owner  'root'
    group  node['apache']['root_group']
 end
 
 bash "extracting files" do
   cwd "/var/www"
   code <<-EOH
   unzip site.zip 
   EOH
   not_if {File.exists?("/var/www/images")}
 end 
 
template "/var/www/index.html" do
    source "index.html.erb"
    mode  '0644'
    owner 'root'
    group node['apache']['root_group']
end
