class CreateReview
  include Dry::Transaction(container: MainContainer)
  step :create_review, with: 'reviews.create'
  step :update, with: 'reviews.update_rating'
end