require './lib/apis/google_places/find_place'

module GooglePlaces
  class PlaceSearch
    include FindPlace

    BASE_URL = 'https://maps.googleapis.com/maps/api'.freeze

    def initialize
      @query_params = []
      check_api_key
    end

    def base_url
      BASE_URL
    end

    def check_api_key
      unless GooglePlaces.api_key
        raise StandardError.new('No API key provided. ' \
      'Set your API key using "GooglePlaces.api_key = <API-KEY>". ')
      end
    end
  end
end
