require 'spec_helper'

describe 'sample-app::default' do
  describe command('/usr/bin/java -version') do
    its(:stderr) { should contain('1.7') }
  end

  describe command('/usr/local/maven-3.3.9/bin/mvn --version') do
    its(:stdout) { should contain('3.3.9') }
  end

  describe service('mysql-app') do
    it { should be_enabled }
    it { should be_running }
  end
end
