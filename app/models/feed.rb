class Feed < ActiveRecord::Base
  STATUSES = %w(ok error)

  attr_accessible :title, :description, :url, :site_url, :last_modified_at, :status

  belongs_to :user
  has_many :posts, dependent: :destroy

  validates :user,  presence: true
  validates :title, presence: true
  validates :url,   presence: true, uniqueness: { scope: :user_id }

  scope :recent, order('last_modified_at DESC')

  after_commit :sync_posts, on: :create

  def sync_posts
    FeedWorker.perform_async(self.id)
  end

  def read_all
    posts.unread.update_all(read_at: Time.now)
    restat!
  end

  def restat!(save_record=false)
    self.posts_count = posts.count
    self.unread_posts_count = posts.unread.count

    save if save_record

    self
  end

  def self.import(url)
    FeedImport.new(url).run
  end
end