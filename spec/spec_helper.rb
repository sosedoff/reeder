ENV['RACK_ENV'] = 'test'

require 'simplecov'
SimpleCov.start

require 'sinatra'
require 'rack/test'
require 'fabrication'
require 'database_cleaner'

require './application'

module ApiHelper
  def json_response
    JSON.parse(last_response.body)
  end

  def json_error
    json_response['error']
  end
end

Fabrication.configure do |config|
  config.fabricator_path = 'spec/fabricators'
  config.path_prefix     = '.'
  config.sequence_start  = 10000
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include ApiHelper

  config.before(:suite) do
    DatabaseCleaner.strategy = :deletion
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
    Redis.current.flushall
  end
end

def app
  Reeder::Application
end

