web: bundle exec puma -C config/puma.rb
resque: QUEUE=* bundle exec rake environment resque:work
scheduler: bundle exec rake resque:scheduler
