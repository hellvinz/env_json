require "env_json/version"
require "json"

# Module containing utilities for loading a JSON file into environments variables. see {EnvJson#load_env_from_source_with_overrides}
module EnvJson
  module_function

  # Load environments variables from a source into ENV
  #
  # @param json [#read] any source that can be read by JSON.load
  # @param environment_name [#to_str, nil] the environment name from where to take overrides
  # @return [Hash] the loaded environment variables
  def load_env_from_source_with_overrides(json, environment_name=nil)
    json = JSON.load(json)
    generate_configuration(json, environment_name).tap do |configuration|
      apply_env(configuration)
    end
  end

  # @!visibility private
  def generate_configuration(raw_hash, environment_name=nil, configuration={})
    raw_hash.inject(configuration) do |conf, (key,value)|
      next conf if key =~ /^_/

      if key == environment_name
        conf = generate_configuration(value, environment_name, conf)
      elsif not value.is_a? String and key =~ /^(test|development|staging|production)/
        # skip other environments keys
        next conf
      else
        conf[key] = value
      end
      conf
    end
  end

  # @!visibility private
  def apply_env(configuration)
    configuration.each do |key,value|
      ENV[key] ||= value
    end
  end
end

require 'env_json/railtie' if defined?(Rails)
