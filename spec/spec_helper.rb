ENV['RACK_ENV'] = 'test'

require 'simplecov'
SimpleCov.start

require 'sinatra'
require 'rack/test'
require 'fabrication'
require 'database_cleaner'

require './application'

Fabrication.configure do |config|
  config.fabricator_path = 'spec/fabricators'
  config.path_prefix     = File.dirname(__FILE__)
  config.sequence_start  = 10000
end

RSpec.configure do |config|
  config.include Rack::Test::Methods

  config.before(:suite) do
    DatabaseCleaner.strategy = :deletion
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

def app
  Reeder::Application
end