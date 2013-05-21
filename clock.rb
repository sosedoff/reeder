require './environment'
require 'clockwork'

include Clockwork

every(1.hour, 'feeds.sync') do
  # TODO: Update feeds
end