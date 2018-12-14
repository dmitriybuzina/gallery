FactoryBot.define do
  factory :comment do |f|
    f.body { Faker::Lorem.sentence }
    f.image_id { FactoryBot.create(:image).id }
    f.user_id { FactoryBot.create(:user).id }

    association :image, factory: :image
  end
end