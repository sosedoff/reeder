require 'spec_helper'

describe Reeder::Application do
  describe 'GET /' do
    it 'renders home page' do
      get '/'
      expect(last_response.status).to eq 200
    end
  end

  describe 'GET /feeds' do
    context 'when no feeds exist' do
      it 'returns an empty collection' do
        get '/feeds'

        expect(last_response.status).to eq 200
        expect(json_response).to be_empty
      end
    end

    context 'when feeds exist' do
      before { Fabricate(:feed) }

      it 'returns a collection of feeds' do
        get '/feeds'

        expect(last_response.status).to eq 200
        expect(json_response).not_to be_empty
        expect(json_response[0]['title']).to eq 'Blog'
      end
    end
  end

  describe 'GET /feeds/:id' do
    it 'returns error if feed does not exist' do
      get '/feeds/12345'

      expect(last_response.status).to eq 404
      expect(json_error).to eq 'Feed does not exist'
    end

    context 'for existing feed' do
      let!(:feed) { Fabricate(:feed) }

      it 'returns feed details' do
        get "/feeds/#{feed.id}"

        expect(last_response.status).to eq 200
        expect(json_response['id']).to eq feed.id
      end
    end
  end

  describe 'POST /feeds' do
    it 'returns error if feed attributes are missing' do
      post '/feeds'

      expect(last_response.status).to eq 400
      expect(json_error).to eq 'Feed attributes required'
    end

    it 'returns feed validation errors' do
      post '/feeds', feed: {title: "Foo"}

      expect(last_response.status).to eq 422
      expect(json_error).to eq "Url can't be blank"
    end

    it 'returns feed instance' do
      post '/feeds', feed: {title: "Foo", url: 'http:/foo.com'}

      expect(last_response.status).to eq 200
      expect(json_response).to include 'id', 'title', 'url'
    end
  end

  describe 'POST /feeds/import' do
    it 'requires feed url parameter' do
      post '/feeds/import'

      expect(last_response.status).to eq 400
      expect(json_error).to eq 'Feed URL required'
    end

    it 'returns error on invalid feed url' do
      post '/feeds/import', url: 'http://foo.bar'

      expect(last_response.status).to eq 400
      expect(json_error).to eq 'Invalid feed URL'
    end

    it 'returns a new feed details' do
      post '/feeds/import', url: 'https://news.ycombinator.com/rss'

      expect(last_response.status).to eq 200
      expect(json_response).to be_a Hash
    end
  end
end