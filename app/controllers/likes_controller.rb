class LikesController < ApplicationController
  before_action :set_image
  before_action :set_like, only: :destroy

  def new
    @like = Like.new
  end

  def create
    @like = @image.likes.create(user_id: current_user.id)
    redirect_to category_image_path(@image) if @like.save
  end

  def destroy
    redirect_to category_image_path(@image) if @like.destroy
  end

  private
  def set_image
    @image = Image.find(params[:image_id])
  end

  def set_like
    @like = Like.where(user_id: current_user.id, image_id: params[:image_id]).first
  end
end
