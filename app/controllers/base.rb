class Reeder::Application
  get '/api/*' do
    json_error("Invalid route", 404)
  end

  get '/stats' do
    json_response(
      users: User.count,
      feeds: Feed.count,
      posts: Post.count
    )
  end

  get '/*' do
    redirect '/'
  end
end