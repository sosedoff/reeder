class PostPresenter < Presenter
  attribute :id, :feed_id
  attribute :title, :author, :url, :content
  attribute :published_at
  attribute :read_at, :bookmarked
end