require 'pty'
require 'shellwords'

namespace :env_json do
  desc 'print env_json computed environment'
  task print_env: :environment do
    pp EnvJson.env
  end

  desc 'load env into ElasticBeanstalk'
  task eb: :environment do
    eb_formated_env = EnvJson.env.map{|key,value| "#{Shellwords.escape key}=#{Shellwords.escape value}" }.join(' ')
    begin
      PTY.spawn("eb setenv -v #{eb_formated_env}") do |stdin, stdout, pid|
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
