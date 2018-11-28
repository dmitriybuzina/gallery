class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy, :new_folower, :delete_folower]
  before_action :authenticate_user!

  def index
    @categories = Category.all
    @category = Category.new
    activity('navigation')
  end

  def show
    @images = @category.images.page(params[:page]).per(5)
    activity('navigation')
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new(category_params)
    @category.user_id = current_user.id
    @category.counter = 0
    redirect_to categories_path if @category.save
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_path
  end

  def new_folower
    if current_user.follow(@category)
      redirect_to categories_path
      Resque.enqueue(FollowMail, current_user.id, @category.id)
      # UserMailer.with(user: current_user, category: @category).follow_email.deliver_now
    end
  end

  def delete_folower
    redirect_to categories_path if current_user.stop_following(@category)
  end

  private

  # def preview
  #   @preview_category = Hash.new
  #   @categories.each do |category|
  #     @preview_category[category: category.images.limit(4)]
  #   end
  #   puts @preview_category
  # end

  def set_category
    @category = Category.friendly.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
