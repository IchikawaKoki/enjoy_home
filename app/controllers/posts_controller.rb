class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    tag_list = params[:post][:name].split(",")
    if @post.save
       @post.save_tags(tag_list)
       redirect_to posts_path
    else
       render :new
    end
  end

  def index
    @posts = Post.all.page(params[:page]).per(3)
    @ranking = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
    @tags = Tag.all
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def favorite
  end

  def edit
    @post = Post.find(params[:id])
    @tag_list = @post.tags.pluck(:name).join(",")
  end

  def update
    @post = Post.find(params[:id])
    tag_list = params[:post][:name].split(",")
    if @post.update(post_params)
       @post.save_tags(tag_list)
       redirect_to post_path(@post.id)
    else
       render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :image)
  end

  def correct_user
    @post = Post.find(params[:id])
    if @post.user != current_user
       redirect_to posts_path
    end
  end
end
