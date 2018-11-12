class WelcomeController < ApplicationController
  def index
    @images = Image.order('created_at DESC').limit(16)
  end
end
