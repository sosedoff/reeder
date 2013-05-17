class Reeder::Application
  get '/api/posts' do
    posts = Post.recent.paginate(page: params[:page], per_page: posts_per_page)
    json_response(posts)
  end

  get '/api/posts/:id' do
    json_response(find_post)
  end

  post '/api/posts/:id/read' do
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