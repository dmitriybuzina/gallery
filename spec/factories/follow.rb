FactoryBot.define do
  factory :follow do |f|
    f.category_id { FactoryBot.create(:category).id }
    f.user_id { FactoryBot.create(:user).id }
  end
end