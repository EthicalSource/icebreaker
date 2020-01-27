require 'resque/scheduler'
require 'resque/scheduler/server'

if ENV["REDIS_URL"].present?
  uri = URI.parse(ENV["REDIS_URL"])
  Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
else
  Resque.redis = Redis.new
end
Resque.logger = ActiveSupport::Logger.new(STDOUT)
Resque.schedule = YAML.load_file(File.join(Rails.root, './config/scheduler.yml'))
