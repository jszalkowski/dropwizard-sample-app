require 'spec_helper'

describe 'sample-app::java' do
  describe command('/usr/bin/java -version') do
    its(:stderr) { should contain('1.8') }
  end
end
