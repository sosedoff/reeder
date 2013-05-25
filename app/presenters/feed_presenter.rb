class FeedPresenter < Presenter
  attribute :id,
            :title,
            :description,
            :url,
            :site_url,
            :last_modified_at,
            :status,
            :created_at,
            :updated_at
end