$LOAD_PATH << '.'
ENV['RACK_ENV'] ||= 'development'

require 'bundler/setup'
require 'yaml'
require 'active_record'
require 'loofah'
require 'feedzirra'
require 'sidekiq'

require 'config/initializers/active_record'
require 'config/initializers/sidekiq'

autoload :Feed,       'app/models/feed'
autoload :Post,       'app/models/post'
autoload :FeedWorker, 'app/workers/feed_worker'
autoload :FeedImport, 'lib/feed_import'
autoload :FeedSync,   'lib/feed_sync'
autoload :OpmlParser, 'lib/opml_parser'