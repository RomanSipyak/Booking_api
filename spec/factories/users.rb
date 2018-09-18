require 'faker'
FactoryBot.define do


  factory :user do
    username 'Roman'
    password '123456789'
    email Faker::Internet.unique.email
  end

  factory :random_user, class: User do
    username Faker::Name.unique.name
    password '123456789'
    email { Faker::Internet.unique.email }
    city { create(:random_city) }
  end
end
