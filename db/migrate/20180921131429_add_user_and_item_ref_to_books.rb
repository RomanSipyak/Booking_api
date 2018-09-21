class AddUserAndItemRefToBooks < ActiveRecord::Migration[5.2]
  def change
    add_reference :books, :item, foreign_key: true
    add_reference :books, :user, foreign_key: true
  end
end

