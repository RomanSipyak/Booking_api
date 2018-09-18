require 'faker'
FactoryBot.define do
  factory :random_city , class: City do
    title Faker::Witcher.unique.location
  end
  factory :city do
    title 'Truskavets'
  end
end
