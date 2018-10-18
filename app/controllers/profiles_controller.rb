class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.find(current_user.id)
    @categories = Category.joins("INNER JOIN follows ON categories.id = follows.followable_id
                                  INNER JOIN users ON follows.follower_id = user_id
                                  Where user_id = #{current_user.id}").all
  end

  def show

  end


end
