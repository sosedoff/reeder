class Reeder::Application
  get '/api/posts' do
    present(recent_posts, as: :post, include: :feed, paginate: true)
  end

  get '/api/posts/search' do
    query = params[:query].to_s.strip

    if query.blank?
      json_error("Search query required")
    end

    scope = Post.
      includes(:feed).
      joins(:feed).
      where('feeds.user_id = ?', api_user.id).
      search_by_query(query)

    posts = scope.paginate(
      page: params[:page], 
      per_page: posts_per_page
    )

    present(posts, as: :post, include: :feed, paginate: true)
  end

  get '/api/posts/:id' do
    present(find_post, as: :post)
  end

  post '/api/posts/:id/read' do
    json_response(read: find_post.read!.read?)
  end

  post '/api/posts/:id/bookmark' do
    json_response(bookmarked: find_post.bookmark!.bookmarked)
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
    25
  end

  def recent_posts
    scope = Post.recent.
      includes(:feed).
      joins(:feed).
      where('feeds.user_id = ?', api_user.id)

    if param_flag(:bookmarked)
      scope = scope.where('posts.bookmarked = ?', true)
    end

    if param_flag(:unread)
      scope = scope.where('posts.read_at IS NULL')
    end

    scope.paginate(
      page: params[:page], 
      per_page: posts_per_page
    )
  end

  def param_flag(name)
    params[name] =~ /\A(true|1|yes)\z/ ? true : false
  end
end