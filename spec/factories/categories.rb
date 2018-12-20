FactoryBot.define do
  factory :category do |f|
    f.name { Faker::Lorem.word }
    f.user_id { FactoryBot.create(:user).id }
    # f.counter { Faker::Number.non_zero_digit }
  end

  factory :category_with_images, class: 'Category' do
    name { 'CategoryName' }
    association :user, factory: :user
    after(:create) do |category|
      create_list(:image, rand(6..10), category: category)
    end
  end

  factory :category_with_six_images, class: 'Category' do
    name { 'CategoryName' }
    association :user, factory: :user
    after(:create) do |category|
      create_list(:image, 6, category: category)
    end
  end
end