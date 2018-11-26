class UserMailer < ApplicationMailer
  default from: 'gallery@example.com'

  def welcome_email
    @user = params[:user]
    @url  = 'http://localhost:3000/en/users/sign_in'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  def follow_email
    @user = params[:user]
    @category = params[:category]
    @url = "http://localhost:3000/ru/categories/#{ @category.name }"
    mail(to: @user.email, subject: "Follow to #{ @category.name }")
  end

  def new_image_email
    @user = params[:user]
    @image = params[:image]
    @category = Category.find(@image.category_id)
    @url = "http://localhost:3000/ru/categories/#{ @category.name }/#{ @image.id }"
    mail(to: @user.email, subject: "New image in #{ @category.name }")
  end

end
