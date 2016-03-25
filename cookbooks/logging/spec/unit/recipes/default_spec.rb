require 'spec_helper'

describe 'logging::default' do
  let(:chef_run) do
    runner = ChefSpec::SoloRunner.new
    runner.converge(described_recipe)
  end

  it 'includes needed recipes' do
    expect(chef_run).to include_recipe('java')
    expect(chef_run).to include_recipe('apt')
    expect(chef_run).to include_recipe('logging::elasticsearch')
    expect(chef_run).to include_recipe('logging::logstash')
    expect(chef_run).to include_recipe('logging::kibana')
  end
end
