require_relative 'boot'
require 'dotenv'
Dotenv.load

require 'rails/all'

Bundler.require(*Rails.groups)

module Icebreaker
  class Application < Rails::Application
    config.load_defaults 6.0
    config.autoload_paths << "#{Rails.root}/app/services/*"
    config.active_job.queue_adapter = :resque
    Resque.schedule = YAML.load_file(File.join(Rails.root, './config/scheduler.yml'))
  end
end
