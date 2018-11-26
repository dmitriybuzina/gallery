FactoryBot.define do
  factory :category do |f|
    f.name { Faker::Name.name }
    f.user_id { FactoryBot.create(:user).id }
    # f.user_id { Faker::Number.non_zero_digit }
    f.counter { Faker::Number.non_zero_digit }
  end
end