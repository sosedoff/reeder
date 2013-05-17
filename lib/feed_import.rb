class FeedImport
  def initialize(url)
    @url = url
  end

  def run
    feed = get_feed_details

    if feed
      record = Feed.find_by_url(feed.feed_url) 
      return record if record.present?

      Feed.create(
        title:            feed.title,
        url:              feed.feed_url,
        site_url:         feed.url || feed.feed_url,
        last_modified_at: feed.last_modified,
        status:           'ok'
      )
    end
  end

  private

  def get_feed_details
    result = Feedzirra::Feed.fetch_and_parse(@url)
    result.class.name =~ /Feedzirra/ ? result : nil
  end
end