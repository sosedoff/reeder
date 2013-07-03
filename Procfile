web: bundle exec thin start -p $PORT
worker: bundle exec sidekiq -c 5 -r ./environment.rb
clock: bundle exec clockwork ./clock.rb
