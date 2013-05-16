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
    end

    get '/' do
      @feeds = Feed.recent
      @posts = Post.includes(:feed).recent.limit(100)

      erb :index
    end

    require 'app/controllers/feeds'
    require 'app/controllers/posts'

    get '/*' do
      json_error("Invalid route", 404)
    end
  end
end