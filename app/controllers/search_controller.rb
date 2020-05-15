class SearchController < ApplicationController

  def search
    if params['search-keyword'].blank?
      redirect_to welcome_index_path
      return
    end
    @users = User.search(params['search-keyword'])
    render :search_results
  end

end
