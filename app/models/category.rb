class Category < ApplicationRecord
  has_many :items, dependent: :nullify
  validates :title, presence: true
end
