class SearchController < ApplicationController

  def search
    p '============================= Params =================================='
    p params
    if params[:q].blank?
      return
    end
    @posts = User.search(params[:q])
    p '============================= Posts =================================='
    p @posts
    p @posts.first
    p '============================= End =================================='
  end

end
