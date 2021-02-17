class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:destroy]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
       @post.create_notification_comment!(current_user, @comment.id)
    else
       render 'posts/show'
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    comment = @post.comments.find(params[:id])
    comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def correct_user
    @post = Post.find(params[:post_id])
    comment = @post.comments.find(params[:id])
    if comment.user != current_user
      redirect_to post_path(@post.id)
    end
  end
end
