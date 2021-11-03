class Api::V1::SearchController < ApplicationController
  before_action :authenticate_user!

  def create
    unless params[:keyword] && params[:location]
      render json: {error: "Params missing"}.to_json, status: 400
      return
    end

    api = GooglePlaces::PlaceSearch.new()

    begin
      @response = api.find_place(params[:keyword], Oj.load(params[:location]))
      render json: @response
    rescue StandardError => error
      render json: {error: error}.to_json, status: 400
    end
  end

  private

  def search_params
    params.require(:search).permit(:keyword, :location)
  end
end
