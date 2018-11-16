class WelcomeController < ApplicationController
  def index
    @images = Image.order('created_at DESC').limit(12)
  end
end
