require 'sinatra'
require 'sinatra/assetpack'
require 'sinatra/activerecord'

module Reeder
  class Application < Sinatra::Application
    register Sinatra::AssetPack
    register Sinatra::ActiveRecordExtension

    configure do
      set :root,       File.join(File.dirname(__FILE__), 'app')
      set :public_dir, 'app/assets'
      set :views,      'app/views'
    end

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

    get '/' do
      erb :index
    end
  end
end