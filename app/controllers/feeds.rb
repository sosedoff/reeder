class Reeder::Application
  get '/api/feeds' do
    present(recent_feeds, as: :feed)
  end

  get '/api/feeds/:id' do
    present(feed, as: :feed)
  end

  get '/api/feeds/:id/posts' do
    present(feed_posts, as: :post, include: :feed, paginate: true)
  end

  post '/api/feeds' do
    if params[:feed].nil?
      json_error("Feed attributes required")
    end

    feed = api_user.feeds.new(params[:feed])

    if feed.save
      json_response(feed)
    else
      json_error(feed.errors.full_messages.first, 422)
    end
  end

  post '/api/feeds/import' do
    url = params[:url].to_s

    if url.empty?
      json_error("Feed URL required")
    end

    if api_user.feeds.find_by_url(url)
      json_error("Feed already exists")
    end

    feed = FeedImport.new(api_user, url).run

    if feed
      present(feed, as: :feed)
    else
      json_error("Invalid feed URL")
    end
  end

  post '/api/feeds/import/opml' do
    data = params[:opml].to_s

    if data.empty?
      json_error("OPML data required")
    end

    feeds = OpmlImport.new(data, api_user).run
  
    present(feeds, as: :feed)
  end

  delete '/api/feeds/:id' do
    if feed.destroy
      json_response(deleted: true)
    else
      json_error("Unable to delete feed")
    end
  end

  private

  def feed
    @feed = api_user.feeds.find_by_id(params[:id])

    if @feed.nil?
      json_error("Feed does not exist", 404)
    end

    @feed
  end

  def feed_posts
    feed.posts.includes(:feed).recent
  end

  def recent_feeds
    api_user.feeds.recent
  end
end