require 'spec_helper'

describe FeedImport do
  let(:user) { Fabricate(:user) }

  describe '#run' do
    it 'returns nil for invalid url' do
      expect(FeedImport.new(user, 'http://invalid_url.foobar').run).to eq nil
    end

    it 'returns nil for non-existent url' do
      expect(FeedImport.new(user, 'http://this-domain-does-not-exist.com').run).to eq nil
    end

    it 'returns nil for non-rss url' do
      expect(FeedImport.new(user, 'http://google.com').run).to eq nil
    end

    it 'creates and returns new feed instance' do
      feed = FeedImport.new(user, 'https://news.ycombinator.com/rss').run

      expect(feed).to be_a Feed
      expect(feed.title).to eq 'Hacker News'
      expect(feed.url).to eq 'https://news.ycombinator.com/rss'
      expect(feed.site_url).to eq 'https://news.ycombinator.com/'
    end
  end
end