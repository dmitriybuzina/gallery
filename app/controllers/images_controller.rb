class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :new_like, :delete_like]

  def index
    @images = Image.all
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
    @images = Image.all.where("category_id = ?", params[:id])

  end

  def new_like
    @user = current_user
    if @user.like!(@image)
      redirect_to images_path
    end
  end

  def delete_like
    if current_user.unlike!(@image)
      redirect_to image_path
    end
  end

  private
  def image_params
    params.require(:image).permit(:path, :category_id, :file)
  end
  def set_image
    @image = Image.find(params[:id])
  end



end
