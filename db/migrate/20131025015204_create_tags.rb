class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.text :value
      t.integer :user_id
      t.boolean :public, default: true

      t.timestamps
    end
    add_index :tags, :user_id
  end
end
