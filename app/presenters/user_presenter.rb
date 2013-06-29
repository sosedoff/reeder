class UserPresenter < Presenter
  attribute :id, :name, :email, :api_token, :created_at
  attribute :feeds_count
  attribute :gravatar_url

  def md5_hash
    Digest::MD5.hexdigest(record.email)
  end

  def gravatar_url
    "http://www.gravatar.com/avatar/#{md5_hash}"
  end
end