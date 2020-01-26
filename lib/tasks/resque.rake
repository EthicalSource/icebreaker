require "resque/tasks"
require 'resque/scheduler/tasks'

namespace :resque do
  task :setup => :environment
  task :setup_schedule => :setup do
    require 'resque-scheduler'
  end
  task :scheduler => :setup_schedule
end
