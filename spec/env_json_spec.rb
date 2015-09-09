require_relative './spec_helper'

class EnvJsonTest < MiniTest::Spec
  describe 'generate_configuration' do
    it 'should generate a configuration hash' do
      json = JSON.load '{"bla":"bla"}'
      conf = EnvJson.generate_configuration(json, 'test')
      conf.must_equal({ 'bla' => 'bla' })
    end

    it 'should generate a configuration hash with environment overrides' do
      json = JSON.load '{"bla":"bla", "test": { "bla" : "notbla" } }'
      conf = EnvJson.generate_configuration(json, 'test')
      conf.must_equal({ 'bla' => 'notbla' })
    end

    it 'should skip not selected environment overrides' do
      json = JSON.load '{"bla":"bla", "test": { "bla" : "notbla" }, "production": {"bla" : "ohno"} }'
      conf = EnvJson.generate_configuration(json)
      conf.must_equal({ 'bla' => 'bla' })
    end
  end

  describe 'apply_env' do
    #cleanup
    after do
      ENV['bla'] = nil
    end

    it 'should apply configuration hash to ENV' do
      ENV['bla'].must_equal nil
      EnvJson.apply_env({ 'bla' => 'bla' })
      ENV['bla'].must_equal 'bla'
    end
  end

  describe 'load_env_from_source_with_overrides' do
    #cleanup
    after do
      ENV['bla'] = nil
    end

    it 'should load json into env' do
      json = '{"bla":"bla"}'
      EnvJson.load_env_from_source_with_overrides(json, 'test')
      ENV['bla'].must_equal 'bla'
    end

    it 'should load json into env with a nil environment_name' do
      json = '{"bla":"bla"}'
      EnvJson.load_env_from_source_with_overrides(json)
      ENV['bla'].must_equal 'bla'
    end

    it 'should load json into ENV with environement override' do
      json = '{"bla":"bla", "test": { "bla" : "notbla" } }'
      EnvJson.load_env_from_source_with_overrides(json, 'test')
      ENV['bla'].must_equal 'notbla'
    end

    it 'should return json' do
      json = '{"bla":"bla", "test": { "bla" : "notbla" } }'
      conf = EnvJson.load_env_from_source_with_overrides(json, 'test')
      conf.must_equal({ "bla" => "notbla" })
    end
  end

  describe 'env' do
    #cleanup
    after do
      ENV['bla'] = nil
    end

    it 'should return the build environment' do
      json = '{"bla":"bla", "test": { "bla" : "notbla" } }'
      EnvJson.load_env_from_source_with_overrides(json, 'test')
      EnvJson.env.must_equal({ "bla" => "notbla" })
    end
  end
end
