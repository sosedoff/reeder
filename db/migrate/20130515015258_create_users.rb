class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string   :name
      t.string   :email
      t.string   :password_hash
      t.string   :password_salt
      t.string   :persistence_token
      t.string   :perishable_token
      t.string   :api_token
      t.boolean  :enabled
      t.datetime :created_at
      t.datetime :updated_at
    end

    add_index :users, :email, unique: true
  end
end
