class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_image, only: [:show, :index, :create, :new]

  def index
    @comments = @image.comments.all
  end

  def new
    @comment = Comment.new
    respond_to do |format|
      format.js { render partial: "form", locals: {image: @image}}
    end
  end

  def create
    @comment = Comment.new(comment_params)
    # respond_to do |format|
    #   format.js { render partial: "form", locals: {image: @image}}
    # end
    @comment.user_id = current_user.id
    @comment.image_id = @image.id
    if @comment.save
      redirect_to @image
    end
  end

  def show
    @user = User.comment
  end

  private
  def set_image
    @image = Image.find(params[:image_id])
  end

  def comment_params
    params.require(:comment).permit(:body, :image_id, :user_id)
  end
end
