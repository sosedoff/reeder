class Post < ActiveRecord::Base
  include PgSearch

  attr_accessible :title, :author, :url, :content, :published_at
  attr_accessible :read_at, :bookmarked, :feed_id

  belongs_to :feed

  validates :feed,         presence: true
  validates :title,        presence: true
  validates :url,          presence: true, uniqueness: {scope: :feed_id, message: 'already exists'}
  validates :content,      presence: true
  validates :published_at, presence: true

pg_search_scope :search_by_query,
  against: [:title, :author, :content],
  using: {
    tsearch: {
      prefix: true,
      dictionary: :english
    }
  }

  scope :recent, order('published_at DESC')
  scope :unread, where(read_at: nil)

  def read?       ; read_at.present?   ; end
  def bookmarked? ; bookmarked == true ; end

  def read!
    update_attribute(:read_at, Time.now) if !read?
    self
  end

  def bookmark!
    update_attribute(:bookmarked, true) if !bookmarked
    self
  end
end