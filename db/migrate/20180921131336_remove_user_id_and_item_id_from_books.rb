class RemoveUserIdAndItemIdFromBooks < ActiveRecord::Migration[5.2]
  def change
    remove_column :books, :user_id, :integer
    remove_column :books, :item_id, :integer
  end
end
