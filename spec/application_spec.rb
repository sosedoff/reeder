require 'spec_helper'

describe Reeder::Application do
  describe 'GET /' do
    it 'renders home page' do
      get '/'
      expect(last_response.status).to eq 200
    end
  end
end