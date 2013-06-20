require 'spec_helper'

describe Reeder::Application do
  let(:user) { Fabricate(:user) }
  let(:api_token) { user.api_token }

  describe 'GET /api/profile' do
    it 'returns user profile' do
      get '/api/profile', api_token: api_token

      expect(last_response.status).to eq 200
      expect(json_response['email']).to eq 'john@doe.com'
      expect(json_response['name']).to eq 'John Doe'
      expect(json_response['api_token']).to eq user.api_token
    end
  end

  describe 'PUT /api/profile' do
    context 'when user attributes are missing' do
      it 'requires user attributes' do
        put '/api/profile', api_token: api_token

        expect(last_response.status).to eq 400
        expect(json_error).to eq 'User attributes required'
      end
    end

    context 'when user attributes are empty' do
      it 'returns error' do
        put '/api/profile', api_token: api_token, user: {}

        expect(last_response.status).to eq 400
        expect(json_error).to eq 'User attributes required'
      end
    end

    it 'updates user profile' do
      put '/api/profile', api_token: api_token, user: { name: 'John Appleseed' }

      expect(last_response.status).to eq 200
      expect(json_response['name']).to eq 'John Appleseed'
    end

    context 'when password is present' do
      let(:old_hash) { user.password_hash }

      it 'updates user password' do
        put '/api/profile', api_token: api_token, user: {password: 'qwe123', password_confirmation: 'qwe123'}

        expect(last_response.status).to eq 200
        expect(User.find_by_id(user.id).password_hash).not_to eq old_hash
      end
    end
  end

  describe 'DELETE /api/profile' do
    it 'deletes user profile' do
      delete '/api/profile', api_token: api_token

      expect(last_response.status).to eq 201
      expect(json_response['deleted']).to eq true
      expect(User.find_by_id(user.id)).to eq nil
    end
  end
end