class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.integer :city_id
      t.string :username
      t.float :rating
      t.float :rating_trade
      t.integer :review_count
      t.text :image_data
      t.timestamps
    end
  end
end
