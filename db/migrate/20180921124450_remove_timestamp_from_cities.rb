class RemoveTimestampFromCities < ActiveRecord::Migration[5.2]
  def change
    remove_column :cities, :created_at, :datetime
    remove_column :cities, :updated_at, :datetime
  end
end
