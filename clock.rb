require './environment'
require 'clockwork'

include Clockwork

every(1.hour, 'feeds.sync') do
  Feed.all.each { |f| f.sync_posts }
end