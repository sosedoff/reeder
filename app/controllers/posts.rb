class Reeder::Application
  get '/posts' do
    json_response(Post.recent.limit(posts_per_page))
  end

  get '/posts/:id' do
    json_response(find_post)
  end

  post '/posts/:id/read' do
    json_error("Not implemented", 501)
  end

  private

  def find_post
    @post = Post.find_by_id(params[:id])

    if @post.nil?
      json_error("Post does not exist", 404)
    end

    @post
  end

  def posts_per_page
    50
  end
end