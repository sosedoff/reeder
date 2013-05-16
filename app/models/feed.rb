class Feed < ActiveRecord::Base
  attr_accessible :title, :description, :url, :last_modified_at

  validates :title,            presence: true
  validates :url,              presence: true, uniqueness: true
  validates :last_modified_at, presence: true
end