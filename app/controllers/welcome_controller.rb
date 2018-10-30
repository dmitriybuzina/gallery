class WelcomeController < ApplicationController
  before_action :top_categoties

  def index
  end

  def destroy
  end

  def top_categoties
    # @categories = Category.group(:image).count.limit(1)
  end

end
