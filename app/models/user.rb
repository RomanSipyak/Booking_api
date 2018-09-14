class User < ApplicationRecord
  include ::ImageUploader::Attachment.new(:image)
  has_many :reviews, as: :reviewcontainer
  belongs_to :city, optional: true
  has_many :items, dependent: :destroy
  has_many :books, dependent: :destroy
  has_many :authored_reviews, class_name: 'Review'

  # Necessary to authenticate.
  has_secure_password

  # Basic password validation, configure to your liking.
  validates_length_of :password, maximum: 72, minimum: 8, allow_nil: true, allow_blank: false
  validates_confirmation_of :password, allow_nil: true, allow_blank: false

  before_validation do
    (self.email = email.to_s.downcase) &&
      (self.username = username.to_s.downcase)
  end

  # Make sure email and username are present and unique.
  validates_presence_of :email
  validates_presence_of :username
  validates_uniqueness_of :email
  validates_uniqueness_of :username
  users = Arel::Table.new(:users)
  items = Arel::Table.new(:items)


  scope :users_count_reviews_with_raiting, ->(raiting) { users.join(items).where(items[:rating].eq(raiting)).count }
end
