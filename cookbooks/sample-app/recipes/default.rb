include_recipe 'java'
include_recipe 'maven'

mysql_service 'app' do
  port '3306'
  version '5.5'
  initial_root_password 'root'
  action [:create, :start]
end

mysql2_chef_gem 'default' do
  action [:install]
end

['db_notes', 'db_notes_test'].each do |database_name|
  mysql_database database_name do
    connection(
      :host     => '127.0.0.1',
      :username => 'root',
      :password => 'root'
    )
    action :create
  end
end
