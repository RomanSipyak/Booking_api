module Reviews
  class UpdateRating
    include Dry::Monads::Result::Mixin

    def call(review)
      if review.reviewcontainer_type == 'User'
        update_user(review)
      elsif review.reviewcontainer_type == 'Item'
        update_user_with_item(review)
      end
      Success(review)
    end

    def update_user(review)
      user = review.reviewcontainer
      user.rating = user.reviews.average_rating
      user.save
    end

    def update_user_with_item(review)
      item = review.reviewcontainer
      item.rating = item.reviews.average_rating
      user = item.user
      user.rating_trade = item.user.items.average_rating
      user.save
      item.save
    end

  end
end