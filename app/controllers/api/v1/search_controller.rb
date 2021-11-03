class Api::V1::SearchController < ApplicationController
  before_action :authenticate_user!

  def create
    unless search_params
      render json: {error: "Params missing"}.to_json, status: 400
      return
    end

    api = GooglePlaces::PlaceSearch.new()

    begin
      location_hash = Oj.load(search_params["location"]).symbolize_keys
      @response = api.nearby_search(search_params["keyword"], location_hash)
      render json: @response
    rescue StandardError => error
      render json: {error: error}.to_json, status: 400
    end
  end

  private

  def search_params
    params.permit(:keyword, :location)
  end
end
