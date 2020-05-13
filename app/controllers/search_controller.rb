class SearchController < ApplicationController

  def search
    if params['search-keyword'].blank?
      return
    end
    @users = User.search(params['search-keyword'])
    render :search_results
  end

end
