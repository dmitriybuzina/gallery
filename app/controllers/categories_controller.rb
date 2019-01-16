class CategoriesController < ApplicationController
  respond_to :html, :js
  before_action :set_category, only: [ :show, :edit, :update, :destroy, :new_follower, :delete_follower]
  before_action :authenticate_user!
  def index
    @categories = Category.all
    @categories.each do |category|
      preview(category)
    end
    @category = Category.new
    activity('navigation')
  end

  def show
    @images = @category.images.page(params[:page]).per(6)
    activity('navigation')
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    # @category = current_user.categories.new(category_params)
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

  def new_follower
    @follow = Follow.new(user_id: current_user.id, category_id: @category.id)
    respond_to do |format|
      format.html
      format.js
    end
    if @follow.save
      Resque.enqueue(FollowMail, current_user.id, @category.id)
      # UserMailer.with(user: current_user, category: @category).follow_email.deliver_now
      redirect_to categories_path
    end
  end

  def delete_follower
    find_follow
    redirect_to categories_path if @follow.destroy
  end

  private
  def find_follow
    @follow = Follow.where(user_id: current_user.id, category_id: Category.friendly.find(params[:id])).first
  end

  def set_category
    @category = Category.friendly.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
