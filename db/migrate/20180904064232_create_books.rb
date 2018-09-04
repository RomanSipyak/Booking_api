class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.datetime :start_booking
      t.datetime :end_booking
      t.float :total_price
      t.integer :item_id
      t.integer :user_id
      t.timestamps
    end
  end
end
