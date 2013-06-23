require 'spec_helper'

describe Reeder::Application do
  before do
    Feed.any_instance.stub(:sync_posts).and_return(true)
  end

  let(:user) { Fabricate(:user) }
  let(:feed) { user.feeds.create(url: 'http://url.com', title: 'My Feed') }

  describe 'GET /api/posts' do
    it 'includes posts from user feeds' do
      user2 = Fabricate(:user, email: 'foo@bar.com')
      post  = Fabricate(:post, feed_id: feed.id)

      get '/api/posts', api_token: user.api_token
      expect(last_response.status).to eq 200
      expect(json_response.count).to eq 1

      get '/api/posts', api_token: user2.api_token
      expect(last_response.status).to eq 200
      expect(json_response.count).to eq 0
    end

    it 'includes post feed' do
      Fabricate(:post, feed_id: feed.id)

      get '/api/posts', api_token: user.api_token

      expect(last_response.status).to eq 200
      expect(json_response.first['feed']).to be_a Hash
    end

    context 'with unread = true' do
      before do
        Fabricate(:post, feed_id: feed.id)
        Fabricate(:post, feed_id: feed.id, read_at: Time.now)
      end

      it 'returns only unread posts' do
        get '/api/posts', api_token: user.api_token, unread: true

        expect(last_response.status).to eq 200
        expect(json_response.count).to eq 1
        expect(json_response.first['read_at']).to eq nil
      end
    end

    context 'with bookmarked = true' do
      before do
        Fabricate(:post, feed_id: feed.id, bookmarked: true)
      end

      it 'returns only bookmarked posts' do
        get '/api/posts', api_token: user.api_token, bookmarked: true

        expect(last_response.status).to eq 200
        expect(json_response.count).to eq 1
        expect(json_response.first['bookmarked']).to eq true
      end
    end
  end

  describe 'GET /api/posts/:id' do
    let(:post) { Fabricate(:post, feed_id: feed.id) }

    it 'returns error if post does not exist' do
      get '/api/posts/1234', api_token: user.api_token

      expect(last_response.status).to eq 404
      expect(json_error).to eq 'Post does not exist'
    end

    it 'returns a single post' do
      get "/api/posts/#{post.id}", api_token: user.api_token

      expect(last_response.status).to eq 200
      expect(json_response['id']).to eq post.id
    end
  end

  describe 'POST /api/posts/:id/read' do
    let(:record) { Fabricate(:post, feed_id: feed.id) }

    it 'returns success if post marked as read' do
      post "/api/posts/#{record.id}/read", api_token: user.api_token
      record.reload

      expect(last_response.status).to eq 200
      expect(json_response['read']).to eq true
      expect(record.read_at).not_to eq nil
    end
  end

  describe 'POST /api/posts/:id/bookmark' do
    let(:record) { Fabricate(:post, feed_id: feed.id) }

    it 'returns success if post is bookmarked' do
      post "/api/posts/#{record.id}/bookmark", api_token: user.api_token
      record.reload

      expect(last_response.status).to eq 200
      expect(json_response['bookmarked']).to eq true
      expect(record.bookmarked).to eq true
    end
  end
end