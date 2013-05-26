require 'spec_helper'

describe Post do
  let(:feed) { Fabricate(:feed) }

  it 'has an unique post url' do
    Fabricate(:post, url: "http://foo.com/1", feed_id: feed.id)
    post = Fabricate.build(:post, url: "http://foo.com/1", feed_id: feed.id)

    expect(post).not_to be_valid
    expect(post.errors[:url].first).to match /already exists/
  end

  describe '#read?' do
    let(:post)     { Fabricate(:post, feed_id: feed.id, read_at: Time.now) }
    let(:new_post) { Fabricate(:post, feed_id: feed.id) }

    it 'returns true if post is read' do
      expect(post.read?).to eq true
    end

    it 'returns false if post is new' do
      expect(new_post.read?).to eq false
    end
  end

  describe '#read!!' do
    let(:post) { Fabricate(:post, feed_id: feed.id) }

    it 'marks post as read' do
      post.read!
      expect(post.read_at).to be_a Time
    end
  end

  describe '#bookmarked?' do
    let(:post) { Fabricate(:post, feed_id: feed.id) }

    it 'returns false if not bookmarked' do
      expect(post.bookmarked?).to eq false
    end

    it 'returns true if bookmarked' do
      post.bookmarked = true
      expect(post.bookmarked?).to eq true
    end
  end

  describe '#bookmark!' do
    let(:post) { Fabricate(:post, feed_id: feed.id) }

    it 'marks post as bookmarked' do
      post.bookmark!
      expect(post.bookmarked).to eq true
    end
  end

  describe '.recent' do
    let(:posts) { feed.posts.recent }

    before do
      Fabricate(:post, title: '1', feed_id: feed.id, published_at: Time.mktime(2013, 01, 01))
      Fabricate(:post, title: '2', feed_id: feed.id, published_at: Time.mktime(2013, 01, 02))
    end

    it 'returns posts ordered by publication date' do
      expect(posts.size).to eq 2
      expect(posts[0].title).to eq '2'
      expect(posts[1].title).to eq '1'
    end
  end

  describe '.unread' do
    let(:posts) { feed.posts.unread }

    before do
      Fabricate(:post, feed_id: feed.id)
      Fabricate(:post, feed_id: feed.id, read_at: Time.now)
    end

    it 'returns unread posts only' do
      expect(posts.size).to eq 1
      expect(posts[0].read_at).to eq nil
    end
  end
end