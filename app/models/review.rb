class Review < ApplicationRecord
  include ImageUploader::Attachment.new(:image)
  belongs_to :reviewcontainer, polymorphic: true, counter_cache: :review_count
  belongs_to :user, counter_cache: true, counter_cache: :review_count

  #   scope :everage_rating, -> { average(:rating) }

  def self.average_rating
    average(:rating)
  end
  
  def count_with_rating(rating)
    where(arel_table[:rating].eq(raiting)).count
  end
end
