class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.text :info
      t.integer :song_id
      t.integer :user_id
      t.boolean :public, default: true

      t.timestamps
    end
    add_index :tags, :song_id
    add_index :tags, :user_id
  end
end
