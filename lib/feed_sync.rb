class FeedSync
  def initialize(feed)
    unless feed.kind_of?(Feed)
      raise ArgumentError, 'Feed instance required'
    end

    @feed = feed
  end

  def run
    feed_details = get_feed_details

    if feed_details
      entries = feed_details.entries || []

      entries.each do |e|
        @feed.posts.create(
          title:        e.title,
          author:       e.author,
          url:          e.url,
          published_at: e.published,
          content:      entry_content(e)
        )
      end

      @feed.last_modified_at = feed_details.last_modified
      @feed.restat!(true)
    end
  end

  private

  def get_feed_details
    result = Feedzirra::Feed.fetch_and_parse(@feed.url)
    result = result.class.name =~ /Feedzirra/ ? result : nil
  end

  def entry_content(entry)
    case entry
    when Feedzirra::Parser::ITunesRSSItem
      entry.summary
    else
      entry.content || entry.summary
    end
  end
end