FactoryBot.define do
  factory :item, class: Item do
    name { 'Car' }
    description  { Faker::Name.last_name }
    price { Faker::Number.number(4) }
    user { create(:random_user) }
    category { create(:random_category) }
  end

  factory :random_item, class: Item do
    name { Faker::Name.first_name }
    description { Faker::WorldOfWarcraft.quote}
    price { Faker::Number.decimal(2, 2) }
    user { create(:random_user) }
    category { create(:random_category) }
  end
end
