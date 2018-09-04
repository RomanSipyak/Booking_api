class User < ApplicationRecord
  include ImageUploader::Attachment.new(:image)
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :reviews, as: :reviewcontainer
  belongs_to :city
  has_many :items, dependent: :destroy
  has_many :books, dependent: :destroy
  has_many :authored_reviews , class_name: "Review"


  before_save :initial_rate

  def initial_rate
    self.rating ||= 0
    self.rating_trade ||=0
  end
end
