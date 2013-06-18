class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string   :name
      t.string   :email
      t.string   :crypted_password
      t.string   :password_salt
      t.string   :persistence_token
      t.string   :api_token
      t.boolean  :enabled
      t.datetime :created_at
      t.datetime :updated_at
    end

    add_index :users, :email, unique: true
    add_index :users, :crypted_password
  end
end
