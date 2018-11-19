class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_image, only: [:show, :index, :create, :new]

  def index
    @comments = @image.comments.all
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = @image.comments.create(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      activity('comments')
      redirect_to category_image_path(id: @image.id), remote: true
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