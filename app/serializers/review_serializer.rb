class ReviewSerializer < ActiveModel::Serializer
  attributes :id,
             :comment,
             :user_id,
             :image_data,
             :date,
             :rating,
             :reviewcontainer_id,
             :reviewcontainer_type

  belongs_to :user
end
