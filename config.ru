require 'bundler'

# Load application
require './application.rb'

# Load rack dependencies
require 'rack'
require 'rack/contrib'
require 'rack/revision'

# Rack middleware
use Rack::BounceFavicon
use Rack::Revision
use Rack::Runtime

# Run main sinatra application
run Sinatra::Application