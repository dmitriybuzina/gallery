class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :new_like, :delete_like]
  before_action :parent, only: [:new, :create, :new_like, :delete_like, :show]

  def index
    @images = Image.all.page(params[:page]).per(25)
    activity('navigation') if current_user
  end

  def new
    @image = Image.new
  end

  def create
    @image = @category.images.new(image_params)
    @image.count_likes = 0
    if @image.save!
      redirect_to category_path(@category.slug)
      send_new_image_mail(@image)
    end
  end

  def show
    @category
    @comments = @image.comments.order('created_at')
    respond_to do |format|
      format.json
      format.js
      format.html
    end
    # redirect_to partial: 'images/image_modal'
    activity('navigation')
  end

  def new_like
    @like = Like.new(user_id: current_user.id, image_id: @image.id)
    # redirect_to category_image_path(@category.slug) if @like.save
    @like.save
    activity('like')
  end

  def delete_like
    find_like
    redirect_to category_image_path if @like.destroy
    # @like.destroy
    activity('like')
  end

  private
  def send_new_image_mail(image)
    users = User.joins(follows: :category)
    users.each do |user|
      # UserMailer.with(user: user, image: image).new_image_email.deliver_now
      Resque.enqueue(NewImageMail, user.id, image.id)
    end
  end

  def find_like
    @like = Like.where(user_id: params[:user_id], image_id: params[:image_id]).first
  end

  def parent
    @category ||= Category.friendly.find(params[:category_id])
  end

  def image_params
    params.require(:image).permit(:name, :file, :count_likes)
  end

  def set_image
    @image = Image.find(params[:id])
  end
end
