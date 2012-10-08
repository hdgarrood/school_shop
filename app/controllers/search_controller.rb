class SearchController < ApplicationController
  def index
    search = Search.new(params[:search])

    case search.result
    when :redirect_to_garment
      redirect_to garment_path(search.redirect_id) and return
    when :list
      @results = search.results_list
    end
  end
end
