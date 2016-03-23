include_recipe 'java'
include_recipe 'maven'
include_recipe 'jenkins::master'

jenkins_plugin 'git'
jenkins_plugin 'greenballs'
jenkins_plugin 'junit'
jenkins_plugin 'jobConfigHistory'
jenkins_plugin 'delivery-pipeline-plugin'
jenkins_plugin 'build-pipeline-plugin' do
  notifies :restart, 'service[jenkins]', :delayed
end

package 'git'

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
