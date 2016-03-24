include_recipe 'java'
include_recipe 'maven'
include_recipe 'jenkins::master'

jenkins_plugin 'git'
jenkins_plugin 'greenballs'
jenkins_plugin 'junit'
jenkins_plugin 'jobConfigHistory'
jenkins_plugin 'delivery-pipeline-plugin'
jenkins_plugin 'shiningpanda' do
  notifies :restart, 'service[jenkins]', :delayed
end

package 'git'
package 'python-virtualenv'
package 'python-dev'

mysql_service 'test' do
  port '3306'
  version '5.5'
  initial_root_password 'root'
  action [:create, :start]
end

mysql2_chef_gem 'default' do
  action [:install]
end

mysql_database 'db_notes_test' do
  connection(
    :host     => '127.0.0.1',
    :username => 'root',
    :password => 'root'
  )
  action :create
end

directory "#{node['jenkins']['master']['home']}/.ssh" do
  owner node['jenkins']['master']['user']
  group node['jenkins']['master']['group']
  mode '0700'
end

remote_file "#{node['jenkins']['master']['home']}/.ssh/deployer" do
  source 'https://gist.githubusercontent.com/joebew42/440c14b70ee305af31f6/raw/2ccd359966d523a026123a434dba262ca9a90e79/deployer'
  owner node['jenkins']['master']['user']
  group node['jenkins']['master']['group']
  mode '0600'
end
