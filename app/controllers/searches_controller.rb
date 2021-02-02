class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @word = params[:word]
    @column = params[:column]
    if @column == 'title'
       @posts = Post.search_title(@word)
    else
       @posts = Post.search_content(@word)
    end
  end
end
