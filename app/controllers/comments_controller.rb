class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_image, only: [:show, :index]

  def index
    @comments = @image.comments.all
  end

  def new
    @comment = Comment.new
  end

  def create
   # @image = Image.find(params[:image_id])
    @comment = Comment.new(comment_params)
     @comment.user_id = current_user.id
   #  @comment.image_id = params[:image_id]
   # # @comment.image_id = params[:id]
    @comment.save
  end

  def show
    @comments = Comment.all.where("image_id = ?", params[:id])
  end

  private
  def set_image
    @image = Image.find(params[:image_id])
  end

  def comment_params
    params.require(:comment).permit(:body, :image_id, :user_id)
  end

end
