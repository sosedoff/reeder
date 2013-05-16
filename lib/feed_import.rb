class FeedImport
  def initialize(feed)
    unless feed.kind_of?(Feed)
      raise ArgumentError, 'Feed instance required'
    end

    @feed = feed
  end

  def run
    if source
      Feed.create(
        title:            source.title,
        url:              source.feed_url,
        site_url:         source.url || source.feed_url,
        last_modified_at: source.last_modified
      )
    end
  end

  private

  def source
    @source ||= Feedzirra::Feed.fetch_and_parse(@feed.url)
  end
end