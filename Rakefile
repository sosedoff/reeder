require 'bundler/setup'
require 'sinatra/activerecord/rake'
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