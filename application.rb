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
        '/js/angular-cookies.js',
        '/js/http-auth-interceptor.js',
        '/js/styles.js',
        '/js/formatters.js',
        '/js/helpers.js',
        '/js/reeder/**/**',
      ]

      js_compression  :jsmin
      css_compression :simple
    end

    helpers do
      include ApplicationHelper
      include AuthenticationHelper
    end

    before '/api*' do
      headers['X-Reeder-Version'] = Reeder::VERSION

      if require_authentication?
        authenticate_user
      end
    end

    get '/' do
      erb :index
    end

    get '/splash' do
      erb :splash, layout: false
    end

    get '/signin' do
      erb :signin, layout: false
    end

    get '/signup' do
      erb :signup, layout: false
    end
  end
end

require 'app/controllers/profile'
require 'app/controllers/users'
require 'app/controllers/feeds'
require 'app/controllers/posts'
require 'app/controllers/base'
