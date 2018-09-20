class City < ApplicationRecord
  has_many :users, dependent: :nullify

  validates :title, presence: true
end
