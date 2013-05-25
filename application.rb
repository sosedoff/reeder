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
      def json_response(data)
        content_type :json, encoding: 'utf8'
        data.to_json
      end

      def json_error(message, status=400)
        halt(status, json_response(error: message, status: status))
      end

      def render_partial(name, locals={})
        erb(name.to_sym, layout: false, locals: locals)
      end

      def present(obj, options={})
        klass = Kernel.const_get(Presenter.class_for(obj))

        if obj.respond_to?(:map)
          presenter = obj.map { |k| klass.new(k, options) }
        else
          presenter = klass.new(obj, options)
        end

        json_response(presenter)
      end
    end

    get '/' do
      erb :index
    end

    require 'app/controllers/feeds'
    require 'app/controllers/posts'
    require 'app/controllers/base'
  end
end