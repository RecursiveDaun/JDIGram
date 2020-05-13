class SearchController < ApplicationController

  def search
    if params[:q].blank?
      return
    end
    @users = User.search(params[:q])
  end

end
