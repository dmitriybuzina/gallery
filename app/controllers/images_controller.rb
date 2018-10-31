class ImagesController < ApplicationController
  before_action :set_image, only: [ :new_like, :delete_like, :show ]
  before_action :set_category, only: [:new, :create ]
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
  end

  def new_like
    if current_user.like!(@image)
      Category.increment_counter(:counter, @image.category.id)
      # redirect_to category_image_path
    end
  end

  def delete_like
    if current_user.unlike!(@image)
      Category.decrement_counter(:counter, @image.category.id)
      # redirect_to category_image_path
    end
  end

  private
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
