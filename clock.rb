require './environment'
require 'clockwork'

include Clockwork

every(1.hour, 'feeds.sync') do
  Feed.active.each { |f| f.sync_posts }
end