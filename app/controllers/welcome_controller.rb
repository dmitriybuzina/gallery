class WelcomeController < ApplicationController
  def index
    @images = Image.order('created_at DESC').limit(5)
    @categories = Category.order('created_at DESC').limit(4)
    @categories.each do |category|
      preview(category)
    end
  end
end
