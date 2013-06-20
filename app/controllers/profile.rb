class Reeder::Application
  get '/api/profile' do
    present(api_user, as: 'user')
  end

  put '/api/profile' do
    if params[:user].blank?
      json_error("User attributes required")
    end

    if api_user.update_attributes(user_params)
      present(api_user, as: 'user')
    else
      json_error(user.errors.full_messages.first, 422)
    end
  end

  delete '/api/profile' do
    if api_user.destroy
      json_response({deleted: true}, 201)
    else
      json_error("Unable to delete user account")
    end
  end
end