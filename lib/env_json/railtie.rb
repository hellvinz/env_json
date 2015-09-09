module EnvJson
  # Rails hook to autoload ENV from JSON file before configuration
  class Railtie < Rails::Railtie
    config.before_configuration { load_env }

    # railtie hook to load env with Rails.env as environment name and config/env.json files as source
    def load_env
      EnvJson.load_env_from_source_with_overrides(Rails.root.join('config/env.json'), Rails.env)
    end

    rake_tasks do
      load File.join(__dir__, 'rails_tasks.rb')
    end
  end
end
