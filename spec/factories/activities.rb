FactoryBot.define do
  factory :activity do |f|
    f.user_id { FactoryBot.create(:user).id }
    f.action { Faker::Lorem.words }
    f.url { Faker::Internet.url }
  end
end