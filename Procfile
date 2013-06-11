web: bundle exec thin start -p $PORT
worker: bundle exec sidekiq -r ./environment.rb
clock: bundle exec clockwork ./clock.rb
