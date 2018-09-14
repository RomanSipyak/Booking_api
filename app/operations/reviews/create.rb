module Reviews
  class Create
    include Dry::Monads::Result::Mixin

    def call(params)
      review = Review.new(params)
      review.date = DateTime.current
      if review.save
        Success(review)
      else
        Failure(review.errors.full_messages)
      end
    end
  end
end
