require 'spec_helper'

describe 'sample-app::default' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04').converge(described_recipe) }

  it 'includes needed recipes' do
    expect(chef_run).to include_recipe('java')
    expect(chef_run).to include_recipe('maven')
  end

  it 'installs mysql service' do
    expect(chef_run).to create_mysql_service('app').with(
                          port: '3306',
                          version: '5.5',
                          initial_root_password: 'root'
                        )
  end

  it 'starts mysql service' do
    expect(chef_run).to start_mysql_service('app')
  end

  it 'installs mysql2_chef_gem' do
    expect(chef_run).to install_mysql2_chef_gem('default')
  end

  ['db_notes', 'db_notes_test'].each do |database_name|
    it "creates database #{database_name}" do
      expect(chef_run).to create_mysql_database(database_name)
    end
  end

end
