class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.integer :city_id
      t.string :username
      t.string :email
      t.float :rating, default: 0
      t.float :rating_trade, default: 0
      t.integer :review_count
      t.text :image_data
      t.timestamps
    end
  end
end
