class Reeder::Application
  get '/feeds' do
    json_response(Feed.recent)
  end

  get '/feeds/:id' do
    json_response(find_feed)
  end

  post '/feeds' do
    if params[:feed].nil?
      json_error("Feed attributes required")
    end

    feed = Feed.new(params[:feed])

    if feed.save
      json_response(feed)
    else
      json_error(feed.errors.full_messages.first, 422)
    end
  end

  post '/feeds/import' do
    url = params[:url].to_s

    if url.empty?
      json_error("Feed URL required")
    end

    if Feed.find_by_url(url)
      json_error("Feed already exists")
    end

    feed = FeedImport.new(url).run

    if feed
      json_response(feed)
    else
      json_error("Invalid feed URL")
    end
  end

  delete '/feeds/:id' do
    if find_feed.destroy
      json_response(deleted: true)
    else
      json_error("Unable to delete feed")
    end
  end

  private

  def find_feed
    @feed = Feed.find_by_id(params[:id])

    if @feed.nil?
      json_error("Feed does not exist", 404)
    end

    @feed
  end
end