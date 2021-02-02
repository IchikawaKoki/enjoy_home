class TagsController < ApplicationController
  before_action :authenticate_user!

  def search
    @tag = Tag.find(params[:id])
    @posts = @tag.posts.all
  end
end
