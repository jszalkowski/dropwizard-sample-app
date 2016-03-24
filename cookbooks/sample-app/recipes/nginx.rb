package 'nginx'

cookbook_file '/etc/nginx/sites-available/default' do
  source 'nginx-default-site'
  notifies :restart, 'service[nginx]', :delayed
end

service 'nginx'
