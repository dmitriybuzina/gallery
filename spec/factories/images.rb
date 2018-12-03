FactoryBot.define do
  factory :image do |f|
    f.name { Faker::Lorem.words }
    f.category_id { FactoryBot.create(:category).id }
    f.file { File.open(Rails.root + 'spec/factories/image.jpeg') }
    f.count_likes { Faker::Number.between(0, 20) }

    association :category, factory: :category
  end
end