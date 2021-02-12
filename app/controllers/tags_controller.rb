class TagsController < ApplicationController
  before_action :authenticate_user!

  def search
    @tag = Tag.find(params[:id])
    @posts = @tag.posts.all.order("created_at DESC")
    @ranking = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
    @tags = Tag.all
  end
end
