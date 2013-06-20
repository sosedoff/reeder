require 'spec_helper'

describe Reeder::Application do
  describe 'POST /api/users' do
    it 'requires user attributes' do
      post '/api/users'

      expect(last_response.status).to eq 400
      expect(json_error).to eq 'User attributes required'
    end

    context 'with valid user attributes' do
      let(:user_attributes) do
        {
          name: 'John Doe',
          email: 'john.doe@gmail.com',
          password: 'foobar',
          password_confirmation: 'foobar'
        }
      end

      it 'returns a new user account' do
        post '/api/users', user: user_attributes

        expect(last_response.status).to eq 201
        expect(json_response['id']).not_to be_blank
        expect(json_response['name']).to eq 'John Doe'
        expect(json_response['email']).to eq 'john.doe@gmail.com'
        expect(json_response['api_token']).not_to be_blank
      end
    end
  end
end