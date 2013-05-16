class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :feed_id, null: false
      t.string :title
      t.string :author
      t.string :url
      t.text :content
      t.datetime :published_at
      t.datetime :read_at
      t.datetime :created_at
      t.boolean :bookmarked, default: false
    end

    add_index :posts, :feed_id
    add_index :posts, :published_at
    add_index :posts, [:feed_id, :url]
  end
end