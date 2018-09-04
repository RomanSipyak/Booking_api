class City < ApplicationRecord
  has_many :users, dependent: :destroy

  validates :title, presence: true
end
