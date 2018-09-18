FactoryBot.define do
  factory :book do
    start_booking { DateTime.current + 2.days }
    end_booking { DateTime.current + 10.days }
    item { create(:random_item) }
    user { create(:random_user) }
  end
end
