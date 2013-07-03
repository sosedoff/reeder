class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.integer     :user_id, null: false
      t.string      :title
      t.text        :description
      t.string      :url
      t.string      :site_url
      t.datetime    :last_modified_at
      t.string      :status, limit: 8
      t.integer     :posts_count, default: 0
      t.integer     :unread_posts_count, default: 0
      t.timestamps
    end

    add_index :feeds, :user_id
    add_index :feeds, [:user_id, :url]
    add_index :feeds, [:user_id, :last_modified_at]
  end
end
