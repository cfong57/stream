class AddPublicOnDeleteToUsers < ActiveRecord::Migration
  def change
    add_column :users, :make_public_on_delete, :boolean, default: false
  end
end
