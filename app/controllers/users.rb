class Reeder::Application
  # Create a new user
  # 
  # Required parameters:
  #
  # - user[name]
  # - user[email]
  # - user[password]
  # - user[password_confirmation]
  #
  post '/api/users' do
    if params[:user].blank?
      json_error("User attributes required")
    end

    user = User.new(user_params)

    if user.save
      present(user, as: 'user', status: 201)
    else
      json_error(user.errors.full_messages.first, 422)
    end
  end

  # Authenticate an existing user
  # 
  # Required parameters:
  #
  # - email
  # - password
  #
  post '/api/authenticate' do

  end

  private

  def user_params
    allowed = ['name', 'email', 'password', 'password_confirmation']
    fields  = (params[:user] || {}).select { |k,v| allowed.include?(k) }

    fields 
  end
end