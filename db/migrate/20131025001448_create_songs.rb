class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name
      t.string :audio
      t.text :info
      t.integer :user_id
      t.boolean :public, default: true

      t.timestamps
    end
    add_index :songs, :user_id
  end
end
