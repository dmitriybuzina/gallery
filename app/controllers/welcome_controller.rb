class WelcomeController < ApplicationController
  def index
    @images = Image.order("RANDOM()").limit(8)
    @categories = Category.where('counter > 0').order("RANDOM()").limit(4)
    @categories.each do |category|
      preview(category)
    end
  end
end
