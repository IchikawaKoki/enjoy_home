class TagsController < ApplicationController
  before_action :authenticate_user!

  def search
    @tag = Tag.find(params[:id])
    @posts = @tag.posts.all.order("created_at DESC")
  end
end
