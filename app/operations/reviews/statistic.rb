module Reviews
  class Statistic
    include Dry::Monads::Result::Mixin

    def item_static(params)
      item = Item.includes(:user).find(params[:item_id])
      stars = {}
      sum = item.reviews.count
      if sum != 0
        5.times do |i|
          stars[i+1] = {}
          stars[i+1][:star] = item.reviews.count_reviews_with_raiting(i+1)
          stars[i+1][:percent] = (item.reviews.count_reviews_with_raiting(i+1) / sum.to_f * 5).to_i
        end
      else
        5.times do |i|
          stars[i+1] = {}
          stars[i+1][:star] = 0
          stars[i+1][:percent] = 0
        end
      end
      stars
    end

    def user_review_statistic(params)
      user = User.includes(:reviews).find(params[:user_id])
      stars_reviews = {}
      stars_trade = {}
      #times
      sum_reviews = user.reviews.count
      sum2_trade = user.items.includes(:reviews).count
      if sum_reviews != 0
        5.times do |i|
          stars_reviews[i+1] = {}
          stars_reviews[i+1][:star] = user.reviews.count_reviews_with_raiting(i+1)
          stars_reviews[i+1][:percent] = (user.reviews.count_reviews_with_raiting(i+1) / sum_reviews.to_f * 5).to_i
        end
      else
        5.times do |i|
          stars_reviews[i+1] = {}
          stars_reviews[i+1][:star] = 0
          stars_reviews[i+1][:percent] = 0
        end
      end
      if sum2_trade != 0
        5.times do |i|
          stars_trade[i+1] = {}
          stars_trade[i+1][:star] = user.items.reduce(0) {|sum, x| sum + x.reviews.count_reviews_with_raiting(i+1)}
          stars_trade[i+1][:percent] = (user.items.reduce(0) {|sum, x| sum + x.reviews.count_reviews_with_raiting(i+1)} / sum2_trade.to_f * 5).to_i
        end
      else
        5.times do |i|
          stars_trade[i+1] = {}
          stars_trade[i+1][:star] = 0
          stars_trade[i+1][:percent] = 0
        end
      end
      {stars_reviews: stars_reviews, stars_trade: stars_trade}
    end

    def call(params)
      if params[:user_id]
      res = user_review_statistic(params)

      elsif params[:item_id]
      res = item_static(params)
      end
        Success(res)
    end
  end
end