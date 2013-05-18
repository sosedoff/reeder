require './environment'

require 'sinatra'
require 'sinatra/assetpack'
require 'sinatra/activerecord'
require 'will_paginate'
require 'will_paginate/active_record'

module Reeder
  class Application < Sinatra::Application
    configure do
      set :root,       File.join(File.dirname(__FILE__), 'app')
      set :public_dir, 'app/assets'
      set :views,      'app/views'
    end

    register Sinatra::AssetPack
    register Sinatra::ActiveRecordExtension

    assets do
      serve '/js',     from: 'assets/js'
      serve '/css',    from: 'assets/css'
      serve '/images', from: 'assets/images'

      css :app, [
        '/css/application.css'
      ]

      js :app, [
        '/js/jquery.js',
        '/js/underscore.js',
        '/js/backbone.js',
        '/js/feed.js',
        '/js/post.js',
        '/js/reader.js',
        '/js/application.js'
      ]
    end

    helpers do
      def json_response(data)
        content_type :json, encoding: 'utf8'
        data.to_json
      end

      def json_error(message, status=400)
        halt(status, json_response(error: message, status: status))
      end

      def trim(str, length=20)
        str.size > length ? "#{str[0, length]}..." : str
      end

      def render_partial(name, locals={})
        erb(name.to_sym, layout: false, locals: locals)
      end
    end

    get '/' do
      @feeds = Feed.recent
      @posts = Post.includes(:feed).recent.limit(25)

      erb :index
    end

    get '/feeds/:id' do
      @posts = Feed.find(params[:id]).posts.recent.limit(50)
      erb :feed
    end

    require 'app/controllers/feeds'
    require 'app/controllers/posts'

    get '/api/*' do
      json_error("Invalid route", 404)
    end

    get '/*' do
      redirect '/'
    end
  end
end