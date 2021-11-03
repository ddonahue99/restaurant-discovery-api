class SearchController < ApplicationController
  before_action :authenticate_user!

  def create
    unless params[:keyword] && params[:location]
      render json: {error: "Params missing"}.to_json, status: 400
      return
    end

    api = GooglePlaces::PlaceSearch.new()
    @response = api.find_place(params[:keyword], Oj.load(params[:location]))
    render json: @response
  end

  private

  def search_params
    params.require(:search).permit(:keyword, :location)
  end
end
