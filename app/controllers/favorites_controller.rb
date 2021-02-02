class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post_id: @post.id)
    favorite.save
    @ranking = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = Favorite.find_by(post_id: @post.id, user_id: current_user.id)
    favorite.destroy
    @ranking = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
  end
end
