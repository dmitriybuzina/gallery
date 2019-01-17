class WelcomeController < ApplicationController
  def index
    @images = Image.order("RANDOM()").limit(8)
    @categories = Category.order('created_at DESC').limit(4)
    @categories.each do |category|
      preview(category)
    end
  end
end
