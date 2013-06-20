module AuthenticationHelper
  PUBLIC_ROUTES = {
    'POST' => ['/api/users']
  }

  def authenticate_user
    token = params[:api_token]

    if token.blank?
      json_error("API token required", 401)
    end

    @api_user = User.find_by_api_token(token)

    if @api_user.nil?
      json_error("Invalid API token", 401)
    end
  end

  def require_authentication?
    !PUBLIC_ROUTES[request.request_method].include?(request.path)
  end
end