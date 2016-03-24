user 'deployer' do
  shell '/bin/bash'
  home '/home/deployer'
  manage_home true
  action :create
end

directory '/home/deployer/.ssh' do
  owner 'deployer'
  group 'deployer'
  mode '0700'
end

remote_file '/home/deployer/.ssh/authorized_keys' do
  source 'https://gist.githubusercontent.com/joebew42/cfb85d25199b94461c27/raw/ebf41312424286b302d4b7b8f645931d12e0c4b8/deployer.pub'
  owner 'deployer'
  group 'deployer'
  mode '0600'
  action :create
end
