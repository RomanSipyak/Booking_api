class UpdateRating
  include Dry::Transaction(container: MainContainer)
  step :update, with: 'reviews.update_rating'
end