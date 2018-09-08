class User < ApplicationRecord
  include ::ImageUploader::Attachment.new(:image)
  has_secure_password
  has_many :reviews, as: :reviewcontainer
  belongs_to :city, optional: true
  has_many :items, dependent: :destroy
  has_many :books, dependent: :destroy
  has_many :authored_reviews, class_name: "Review"
  validates :email, uniqueness: true
end
