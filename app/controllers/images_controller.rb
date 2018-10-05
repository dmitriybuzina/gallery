class ImagesController < ApplicationController
  def new
    @image = Image.new
  end

  def create
    @image = Image.new(image_params)
    @image.save!
  end

  private
  def image_params
    params.require(:image).permit(:path, :file)
  end
end
