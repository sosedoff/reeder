class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string      :title
      t.string      :description
      t.string      :url
      t.string      :site_url
      t.datetime    :last_modified_at
      t.string      :status, limit: 8
      t.integer     :posts_count, default: 0
      t.integer     :unread_posts_count, default: 0
      t.timestamps
    end

    add_index :feeds, :url
    add_index :feeds, :last_modified_at
  end
end
