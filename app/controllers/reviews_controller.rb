class ReviewsController < ApplicationController
  before_action :authenticate_user, only: %i[create update index destroy]

  def update
    review = Review.find(params[:id])
    if review.user == current_user
      if review.update(review_params)
        UpdateRating.new.call(review)
        render json: review
      else
        render json: {errors: review.errors}, status: :unprocessable_entity
      end
    else
      render json: {errors: "you can't do it"}, status: :unprocessable_entity
    end
  end

# TEST :  Postman complite and rspec
  def destroy
    review = Review.find(params[:id])
    if review.user == current_user
      review = Review.find(params[:id])
      review.destroy
      render json: {status: :ok}, status: :ok
    else
      render json: {errors: "you can't do it"}, status: :unprocessable_entity
    end
  end

# TEST :  Postman complite and rspec
  def create
    review = CreateReview.new.call(review_params.merge(user: current_user))
    if review.value_or(false)
      render json: review.value!
    else
      render json: {errors: review.failure}, status: :unprocessable_entity
    end
  end

# TEST :  Postman complite
  def index
    res = StatisticReview.new.call(params)
    if params[:user_id]
      user = User.includes(:reviews).find(params[:user_id])
      render json: {statistic: res.value!, reviews: user.reviews}
    elsif params[:item_id]
      item = Item.includes(:user).find(params[:item_id])
      render json: {statistic: res.value!, reviews: item.reviews}
    end
  end

  def review_params
    params.require(:review).permit(:reviewcontainer_type, :comment, :reviewcontainer_id, :image, :rating)
  end
end
