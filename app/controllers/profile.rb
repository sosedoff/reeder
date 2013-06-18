class Reeder::Application
  get '/api/profile' do
    present(api_user, as: 'user')
  end

  put '/api/profile' do
    json_error("Not implemented")
  end
end