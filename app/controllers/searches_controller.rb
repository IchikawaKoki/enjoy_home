class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @word = params[:word]
    @column = params[:column]
    if @column == 'title'
       @posts = Post.search_title(@word).order("created_at DESC")
    else
       @posts = Post.search_content(@word).order("created_at DESC")
    end
  end
end
