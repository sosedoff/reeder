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
      include AuthenticationHelper
    end

    before '/api*' do
      authenticate_user if require_authentication?
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