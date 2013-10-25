class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name
      t.string :audio
      t.integer :user_id
      t.integer :tag_id
      t.boolean :public, default: true

      t.timestamps
    end
    add_index :songs, :user_id
    add_index :songs, :tag_id
  end
end
