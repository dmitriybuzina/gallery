class LikesController < ApplicationController
  before_action :like_params, only: [:new, :create]

  def new
    @like = Like.new(like_params)
  end

  def create
    @like = Like.new(like_params)
    @like.save
  end

  def destroy

  end

  private

  def like_params
    params.require(:like).permit(:user_id, :image_id)
  end
end
