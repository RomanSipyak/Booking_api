class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :description
      t.float :price
      t.integer :user_id
      t.integer :category_id
      t.string :name
      t.float :rating, default: 0
      t.integer :review_count
      t.text :image_data
      t.timestamps
    end
  end
end
