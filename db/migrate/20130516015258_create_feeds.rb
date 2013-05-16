class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :title
      t.string :description
      t.string :url
      t.string :site_url
      t.datetime :last_modified_at
      t.timestamps
    end
  end
end
