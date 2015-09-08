require_relative '../spec_helper'

class VersionTest < MiniTest::Spec
  it 'should have a version number' do
    ::EnvJson::VERSION.wont_be_nil
  end
end
