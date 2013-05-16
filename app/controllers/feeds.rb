class Reeder::Application
  get '/feeds' do
    json_response(Feed.recent)
  end

  get '/feeds/:id' do
    json_response(find_feed)
  end

  post '/feeds' do
    feed = Feed.new(params[:feed])

    if feed.save
      json_response(feed)
    else
      json_error(feed.errors.full_messages.first, 422)
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