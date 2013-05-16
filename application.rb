require './environment'

require 'sinatra'
require 'sinatra/assetpack'
require 'sinatra/activerecord'

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
        '/jquery.js',
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
    end

    get '/' do
      erb :index
    end

    get '/feeds' do
      json_response(Feed.recent)
    end

    get '/feeds/:id' do
      feed = Feed.find_by_id(params[:id])

      if feed.nil?
        json_error("Feed does not exist", 404)
      end

      json_response(feed)
    end
  end
end