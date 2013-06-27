class UserPresenter < Presenter
  attribute :id, :name, :email, :api_token, :created_at
  attribute :feeds_count

  def feeds_count
    record.feeds.count
  end
end