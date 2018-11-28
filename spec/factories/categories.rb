FactoryBot.define do
  factory :category do |f|
    f.name { Faker::Lorem.word }
    f.user_id { FactoryBot.create(:user).id }
    f.counter { Faker::Number.non_zero_digit }
  end
end