class ImagesController < ApplicationController
  before_action :set_image, only: [ :new_like, :delete_like, :show ]
  before_action :set_category, only: [:new, :create]
  def index
    @images = Image.all
    # @images = Image.all.where(category_id: params[:id])
  end

  def new
    @image = Image.new
    # @image.category_id = params[:category_id]
  end

  def create
    @image = @category.images.new(image_params)
    @image.save!
  end

  def show
    @comments = @image.comments
    @likes = Like.count
    # respond_to do |format|
    #   format.js
    # end
  end

  def new_like
    redirect_to category_image_path if current_user.like!(@image)
  end

  def delete_like
    redirect_to category_image_path if current_user.unlike!(@image)
  end

  private

  def parent
    @category ||= Category.find(params[:category_id])
  end

  def set_category
    @category = Category.find(params[:category_id])
  end

  def image_params
    params.require(:image).permit(:path, :category_id, :file)
  end

  def set_image
    @image = Image.find(params[:id])
  end
end
