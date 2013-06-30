class CreateSearchDocuments < ActiveRecord::Migration
  def up
    create_table :pg_search_documents do |t|
      t.text :content
      t.belongs_to :searchable, :polymorphic => true
      t.timestamps
    end
  end

  def down
    drop_table :pg_search_documents
  end
end
