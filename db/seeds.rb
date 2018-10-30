# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

Comment.create!(body: 'Comment1', image_id: 1, user_id: 1)
Comment.create!(body: 'Comment1', image_id: 1, user_id: 1)

Like.create!(liker_id: 1, likeable_id: 1)