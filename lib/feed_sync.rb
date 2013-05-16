class FeedSync
  def initialize(feed)
    unless feed.kind_of?(Feed)
      raise ArgumentError, 'Feed instance required'
    end

    @feed = feed
  end

  def run
    entries.each do |e|
      @feed.posts.create(
        title:        e.title,
        author:       e.author,
        url:          e.url,
        published_at: e.published,
        content:      e.content || e.summary
      )
    end
  end

  private

  def entries
    result = Feedzirra::Feed.fetch_and_parse(@feed.url)
    result ? result.entries : []
  end
end