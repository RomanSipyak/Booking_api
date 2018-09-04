class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.string :comment
      t.integer :user_id
      t.text :image_data
      t.date :date
      t.float :rating
      t.references :reviewcontainer, polymorphic: true, index: true
      t.timestamps
    end
  end
end
