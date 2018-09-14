class UserSerializer < ActiveModel::Serializer
  attributes :id
  has_many :reviews, as: :reviewcontainer
end
