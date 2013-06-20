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
        '/css/application.css',
        '/css/font-awesome.css'
      ]

      js :app, [
        '/js/jquery.js',
        '/js/moment.js',
        '/js/angular.js',
        '/js/angular-resource.js',
        '/js/angular-sanitize.js',
        '/js/styles.js',
        '/js/application.js',
        '/js/controllers.js',
        '/js/helpers.js'
      ]
    end

    helpers do
      include ApplicationHelper
    end

    before '/api*' do
      token = params[:api_token]

      if token.blank?
        json_error("API token required", 401)
      end

      @api_user = User.find_by_api_token(token)

      if @api_user.nil?
        json_error("Invalid API token", 401)
      end
    end

    get '/' do
      erb :index
    end
  end
end

require 'app/controllers/profile'
require 'app/controllers/users'
require 'app/controllers/feeds'
require 'app/controllers/posts'
require 'app/controllers/base'