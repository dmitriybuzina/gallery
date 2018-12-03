FactoryBot.define do
  factory :like do |f|
    f.image_id { FactoryBot.create(:image).id }
    f.user_id { FactoryBot.create(:user).id }
  end
end