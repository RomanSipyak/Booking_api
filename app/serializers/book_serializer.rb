class BookSerializer < ActiveModel::Serializer
  attributes :id,
             :start_booking,
             :end_booking,
             :total_price

  belongs_to :user
  belongs_to :item
end
