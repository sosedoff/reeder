get '/api/*' do
  json_error("Invalid route", 404)
end

get '/*' do
  redirect '/'
end