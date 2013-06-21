class Reeder::Application
  post '/api/users' do
    if params[:user].blank?
      json_error("User attributes required")
    end

    user = User.new(user_params)
    user.password_confirmation = user.password

    if user.save
      present(user, as: 'user', status: 201)
    else
      json_error(user.errors.full_messages.first, 422)
    end
  end

  post '/api/authenticate' do
    email, password = params[:email], params[:password]

    json_error("Email required") if email.blank?
    json_error("Password required") if password.blank?

    user = User.authenticate(email, password)

    if user
      present(user, as: 'user')
    else
      json_error("Invalid email or password")
    end
  end

  private

  def user_params
    allowed = ['name', 'email', 'password']
    fields  = (params[:user] || {}).select { |k,v| allowed.include?(k) }

    fields 
  end
end