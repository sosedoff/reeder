class FeedSync
  def initialize(feed)
    unless feed.kind_of?(Feed)
      raise ArgumentError, 'Feed instance required'
    end

    @feed = feed
  end

  def run
    details = get_feed_details

    if details
      (details.entries || []).each do |e|
        @feed.posts.create(new_post_attributes(e))
      end
      
      @feed.status = 'ok'
      @feed.last_modified_at = details.last_modified
      @feed.restat!(true)
    else
      @feed.update_attribute(:status, 'error')
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

  def new_post_attributes(entry)
    {
      title:        entry.title,
      author:       entry.author,
      url:          entry.url,
      published_at: entry.published || Time.now,
      content:      entry_content(entry)
    }
  end
end