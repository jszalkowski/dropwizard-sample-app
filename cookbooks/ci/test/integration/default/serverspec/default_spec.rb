require 'serverspec'

set :backend, :exec

describe 'ci::default' do
  describe command('/usr/bin/java -version') do
    its(:stderr) { should contain('1.7') }
  end

  describe port(8080) do
    it { should be_listening }
  end
end
