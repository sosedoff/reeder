class FeedImport
  def initialize(user, url)
    @user = user
    @url  = url
  end

  def run
    feed = get_feed_details

    if feed
      record = @user.feeds.find_by_url(feed.feed_url) 
      return record if record.present?

      @user.feeds.create(new_feed_attributes(feed))
    end
  end

  private

  def get_feed_details
    result = Feedzirra::Feed.fetch_and_parse(@url)
    result.class.name =~ /Feedzirra/ ? result : nil
  end

  def detect_site_url(feed)
    if feed.url
      feed.url
    else
      entry = (feed.entries || []).first

      if entry
        uri = URI.parse(entry.url)
        "#{uri.scheme}://#{uri.host}"
      end
    end
  end

  def new_feed_attributes(feed)
    {
      title:            feed.title,
      description:      feed.description,
      url:              feed.feed_url,
      site_url:         detect_site_url(feed),
      last_modified_at: feed.last_modified,
      status:           'ok'
    }
  end
end