require 'spec_helper'

describe Reeder::Application do
  describe 'GET /' do
    it 'renders home page' do
      get '/'
      expect(last_response.status).to eq 200
    end
  end

  describe 'GET /*' do
    it 'redirects non-existent routes to homepage' do
      get '/foo/bar/invalid'

      expect(last_response).to be_a_redirect
      expect(last_response.headers['Location']).to eq 'http://example.org/'
    end
  end

  describe 'GET /api/*' do
    it 'returns error on non-existent endpoint' do
      get '/api/foo/bar'

      expect(last_response.status).to eq 404
      expect(json_error).to eq 'Invalid route'
    end
  end
end