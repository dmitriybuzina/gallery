class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :new_like, :delete_like]
  before_action :parent, only: [:new, :create, :new_like, :delete_like]

  def index
    @images = Image.all
    activity('navigation')
  end

  def new
    @image = Image.new
  end

  def create
    @image = @category.images.new(image_params)
    redirect_to category_path(@category) if @image.save!
  end

  def show
    @comments = @image.comments.order(created_at: :desc)
    activity('navigation')
  end

  def new_like
    @like = Like.new(user_id: current_user.id, image_id: @image.id)
    redirect_to category_image_path if @like.save
    activity('like')
  end

  def delete_like
    find_like
    redirect_to category_image_path if @like.destroy
    activity('like')
  end

  private
  def find_like
    @like = Like.where(user_id: params[:user_id], image_id: params[:image_id]).first
  end

  def parent
    @category ||= Category.friendly.find(params[:category_id])
  end

  def image_params
    params.require(:image).permit(:name, :category_id, :file)
  end

  def set_image
    @image = Image.find(params[:id])
  end
end
