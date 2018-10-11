class ImagesController < ApplicationController

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

  private
  def image_params
    params.require(:image).permit(:path, :category_id, :file)
  end

end
