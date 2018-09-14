class StatisticReview
  include Dry::Transaction(container: MainContainer)
  step :statistic, with: 'reviews.statistic'
end