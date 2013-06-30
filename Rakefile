APP_FILE  = 'application.rb'
APP_CLASS = 'Reeder::Application'

require 'bundler/setup'
require 'sinatra/activerecord/rake'
require 'sinatra/assetpack/rake'
require 'pg_search/tasks'
require 'pry'
require './application.rb'

begin
  require 'rspec/core/rake_task'
rescue LoadError
  puts "Rspec is not loaded"
end

if defined?(RSpec)
  RSpec::Core::RakeTask.new(:test) do |t|
    t.pattern = 'spec/**/*_spec.rb'
    t.verbose = false
  end
end

task :environment do
  require './environment'
end