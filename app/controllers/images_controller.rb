class ImagesController < ApplicationController
  before_action :set_image, only: [ :new_like, :delete_like, :show ]
  before_action :set_category, only: [:show, :index]
  def index
    @images = @category.images.all
    # @images = Image.all.where(category_id: params[:id])
  end

  def new
    @image = Image.new
    @image.category_id = params[:category_id]
  end

  def create
    @image = Image.new(image_params)
    @image.save
  end

  def show
    @comments = @image.comments
    respond_to do |format|
      format.js
    end
  end

  def new_like
    if current_user.like!(@image)
      redirect_to images_path
    end
  end

  def delete_like
    if current_user.unlike!(@image)
      redirect_to images_path
    end
  end

  private
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
