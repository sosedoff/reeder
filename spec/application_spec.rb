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
    context 'with api token' do
      let(:api_token) { Fabricate(:user).api_token }

      it 'returns error on non-existent endpoint' do
        get '/api/foo/bar', api_token: api_token

        expect(last_response.status).to eq 404
        expect(json_error).to eq 'Invalid route'
      end
    end

    it 'returns authentication error' do
      get '/api/foo/bar'

      expect(last_response.status).to eq 401
      expect(json_error).to eq 'API token required'
    end
  end
end