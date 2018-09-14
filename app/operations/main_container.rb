class MainContainer
  extend Dry::Container::Mixin

  namespace "reviews" do
    register "create" do Reviews::Create.new end
    register "update_rating" do Reviews::UpdateRating.new end
    register "statistic" do Reviews::Statistic.new end
  end
end