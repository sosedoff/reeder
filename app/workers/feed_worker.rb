class FeedWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false

  def perform(feed_id)
    feed = Feed.find(feed_id)
    FeedSync.new(feed).run
  end
end