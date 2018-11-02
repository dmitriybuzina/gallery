class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :check_like ]
  before_action :check_like, only: [:show]
  before_action :set_category, only: [:new, :create ]
  before_action :decrement, only: :delete_like
  before_action :increment, only: :new_like
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

  def check_like
    if Like.exists?(user_id: current_user.id, image_id: @image.id)
      @check = true
    else
      @check = false
    end
  end

  private

  def decrement
    Category.decrement_counter(:counter, @image.category.id)
  end

  def increment
    Category.increment_counter(:counter, @image.category.id)
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
