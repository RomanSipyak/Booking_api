class ItemSerializer < ActiveModel::Serializer
  attributes :id,
             :description,
             :price,
             :user_id,
             :category_id,
             :name,
             :rating,
             :review_count,
             :image_data
  belongs_to :category
  has_many :reviews, as: :reviewcontainer
  belongs_to :user
  belongs_to :category
  has_many :books
end
