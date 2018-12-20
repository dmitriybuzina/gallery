FactoryBot.define do
  factory :image do |f|
    f.name { Faker::Lorem.words }
    f.category_id { FactoryBot.create(:category) }
    f.file { File.open(Rails.root + 'spec/factories/image.jpeg') }
    f.count_likes { Faker::Number.between(0, 20) }

    association :category, factory: :category
  end

  factory :image_with_comments, class: 'Image' do
    name { 'ImageName' }
    file { File.open(Rails.root + 'spec/factories/image.jpeg') }
    association :category, factory: :category
    after(:create) do |image|
      create_list(:comment, 6, image: image)
    end
  end
end