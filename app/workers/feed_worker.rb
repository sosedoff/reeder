class FeedWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false

  # Set worker feed update timeout
  UPDATE_TIMEOUT = 5

  def perform(feed_id)
    feed = Feed.find(feed_id)
  
    Timeout.timeout(UPDATE_TIMEOUT) do
      FeedSync.new(feed).run
    end
  end
end