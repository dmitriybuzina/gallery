class WelcomeController < ApplicationController
  before_action :top_categoties

  def index
    @images = Image.order('created_at DESC').limit(16)
  end

  def destroy
  end

  def top_categoties
    # @categories = Category.group(:image).count.limit(1)
  end

end
