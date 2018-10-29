class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy, :new_folower, :delete_folower]
  before_action :authenticate_user!

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.all
    @category = Category.new
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @images = @category.images
    # @image = @category.images.build
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)
    @category.user_id = current_user.id
    # @category.save
    # redirect_to @category
    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
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

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    redirect_to categories_path
  end

  def new_folower
    redirect_to categories_path if current_user.follow(@category)
  end

  def delete_folower
    redirect_to categories_path if current_user.stop_following(@category)
  end

  private
  # Use callbacks to share common setup or constraints between actions.rb.
  def set_category
    @category = Category.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def category_params
    params.require(:category).permit(:name)
  end
end
