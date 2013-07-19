$LOAD_PATH << '.'
ENV['RACK_ENV'] ||= 'development'

require 'bundler/setup'
require 'yaml'
require 'active_record'
require 'pg_search'
require 'loofah'
require 'feedzirra'
require 'sidekiq'
require 'base64'
require 'bcrypt'

require 'config/initializers/active_record'
require 'config/initializers/sidekiq'

module Reeder
  VERSION = '0.6.1'
end

autoload :User,          'app/models/user'
autoload :Feed,          'app/models/feed'
autoload :Post,          'app/models/post'
autoload :FeedWorker,    'app/workers/feed_worker'
autoload :UserPresenter, 'app/presenters/user_presenter'
autoload :FeedPresenter, 'app/presenters/feed_presenter'
autoload :PostPresenter, 'app/presenters/post_presenter'

autoload :FeedImport,    'lib/feed_import'
autoload :FeedSync,      'lib/feed_sync'
autoload :OpmlParser,    'lib/opml_parser'
autoload :OpmlImport,    'lib/opml_import'
autoload :Presenter,     'lib/presenter'

autoload :ApplicationHelper,    'app/helpers/application_helper'
autoload :AuthenticationHelper, 'app/helpers/authentication_helper'