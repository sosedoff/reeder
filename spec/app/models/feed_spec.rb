require 'spec_helper'

describe Feed do
  let(:feed) { Fabricate(:feed) }

  describe '#sync_posts' do
    let(:feed) { Feed.first }

    before do
      Fabricate(:feed)
    end

    it 'schedules feed sync in background' do
      FeedWorker.should_receive(:perform_async).with(feed.id)
      feed.sync_posts
    end
  end

  describe '#read_all' do
    before do
      Fabricate(:post, title: '1', feed_id: feed.id)
      Fabricate(:post, title: '2', feed_id: feed.id)
    end

    it 'marks all posts as read' do
      feed.read_all

      expect(feed.posts.unread.count).to eq 0
      expect(feed.unread_posts_count).to eq 0
    end
  end

  describe 'restat!' do
    before do
      Fabricate(:post, title: '1', feed_id: feed.id)
      Fabricate(:post, title: '2', feed_id: feed.id, read_at: Time.now)
    end

    it 'updates posts counters' do
      feed.restat!

      expect(feed.posts_count).to eq 2
      expect(feed.unread_posts_count).to eq 1
    end
  end

  describe 'after commit' do
    context 'on create' do
      it 'schedules feed sync' do
        FeedWorker.should_receive(:perform_async)
        Fabricate(:feed)
      end
    end
  end

  describe '.recent' do
    let(:user)  { Fabricate(:user) }
    let(:feeds) { Feed.recent }

    before do
      Fabricate(:feed, title: 'A', url: 'http://a.com', last_modified_at: Time.mktime(2013, 01, 01), user: user)
      Fabricate(:feed, title: 'B', url: 'http://b.com', last_modified_at: Time.mktime(2013, 01, 02), user: user)
    end

    it 'returns posts ordered by publication date' do
      expect(feeds[0].title).to eq 'B'
      expect(feeds[1].title).to eq 'A'
    end
  end

  describe '.import' do
    it 'imports a new feed from url' do
      url = 'http://foo.com'
      FeedImport.any_instance.should_receive(:run)
      Feed.import(url)
    end
  end
end