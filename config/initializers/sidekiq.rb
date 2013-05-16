redis_url = ENV['REDIS_URL'] || 'redis://localhost'

Sidekiq.configure_server do |config|
  config.redis = {url: redis_url}
end

Sidekiq.configure_client do |config|
  config.redis = {url: redis_url}
end