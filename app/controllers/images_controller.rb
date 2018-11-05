class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :new_like, :delete_like]
  before_action :parent, only: [:new, :create, :new_like, :delete_like]
  before_action :find_like, only: [:delete_like]
  # before_action :like_params, only: [:new_like]

  def index
    @images = Image.all
  end

  def new
    @image = Image.new
  end

  def create
    @image = @category.images.new(image_params)
    @image.save!
  end

  def show
    @comments = @image.comments
  end

  def new_like
    @like = Like.new(user_id: current_user.id, image_id: @image.id)
    if @like.save
      Image.increment_counter(:count_likes, @image)
      Category.increment_counter(:counter, @image.category.id)
      redirect_to category_image_path
    end
  end

  def delete_like
    if @like.destroy
      Image.decrement_counter(:count_likes, @image)
      Category.decrement_counter(:counter, @image.category.id)
      redirect_to category_image_path
    end
  end

  private
  # def like_params
  #   params.require(:like).permit(:user_id, :image_id)
  # end

  def find_like
    @like = Like.where(user_id: params[:user_id], image_id: params[:image_id]).first
  end

  def parent
    @category ||= Category.find(params[:category_id])
  end

  def set_category
    @category = Category.find(params[:category_id])
  end

  def image_params
    params.require(:image).permit(:name, :category_id, :file)
  end

  def set_image
    @image = Image.find(params[:id])
  end
end
