require 'pty'
require 'shellwords'

namespace :env_json do
  desc 'print env_json computed environment'
  task print_env: :environment do
    pp EnvJson.env
  end

  desc 'load env into ElasticBeanstalk'
  task :eb do
    eb_environment_name = ENV['ENVIRONMENT_NAME']

    EnvJson.load_env_from_source_with_overrides(Rails.root.join('config/env.json'), ENV.fetch('RAILS_ENV'))

    eb_formated_env = EnvJson.env.map{|key,value| "#{Shellwords.escape key}=#{Shellwords.escape value}" }.join(' ')
    eb_environment_name_switch = eb_environment_name ? "-e #{eb_environment_name}" : nil
    eb_command = "eb setenv #{eb_environment_name_switch} -v #{eb_formated_env}"

    begin
      PTY.spawn(eb_command) do |stdin, stdout, pid|
        begin
          stdin.each { |line| print line }
        rescue Errno::EIO
          puts "Errno:EIO error, but this probably just means that the process has finished giving output"
        end
      end
    rescue PTY::ChildExited
      puts "The child process exited!"
    end
  end
end
