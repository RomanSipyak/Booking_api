FactoryBot.define do
  factory :random_category, class: Category do
    title Faker::Dota.hero
  end
  factory :category_book, class: Category do
    title 'book'
  end
  factory :category_guitar, class: Category do
    title 'guitar'
  end
end
