class SearchController < ApplicationController
  def agencies
    agencies = Agency.where ['name LIKE ?', "%#{params[:name].to_s}%"]
    render :json => agencies
  end
end
