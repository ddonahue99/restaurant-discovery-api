require './lib/apis/google_places/find_place'

module GooglePlaces
  class PlaceSearch
    BASE_URL = 'https://maps.googleapis.com/maps/api'
    include FindPlace

    def initialize
      check_api_key
      @base_url = BASE_URL
    end

    def check_api_key
      unless GooglePlaces.api_key
        raise StandardError.new('No API key provided. ' \
      'Set your API key using "GooglePlaces.api_key = <API-KEY>". ')
      end
    end
  end
end
