require 'httparty'
require 'oj'
require './lib/apis/google_places/errors'

  module NearbySearch
    include HTTParty

    NEARBY_SEARCH_URL = '/place/nearbysearch/json?'.freeze

    # Call find_places endpoints
    #
    # @param keyword [String] for text query
    # @param location [Hash] of Latitude and Longitude coordinates
    # @return [Hash]
    # @see https://developers.google.com/maps/documentation/places/web-service/search-nearby
    def nearby_search(keyword, location={})
      @query_params = []
      url = build_url(keyword, location)
      HTTParty.get(url).parsed_response["results"]
    end

    private

    def build_url(keyword, location)
      construct_location(location)
      construct_type
      construct_textquery(keyword)
      construct_key
      [base_url, NEARBY_SEARCH_URL, encode_params].join()
    end

    def construct_textquery(keyword)
      @query_params << ["keyword", keyword] if keyword.present?
    end

    def construct_location(location)
        raise FindPlaceAPIError.new('Location geometry invalid.') unless location.keys.sort == [:latitude, :longitude].sort
        @query_params << ["location", "#{location[:latitude]},#{location[:longitude]}"]
    end

    def construct_type
      @query_params << ["radius", "1500"]
      @query_params << ["type", "restaurant"]
    end

    def construct_key
      @query_params << ["key", GooglePlaces.api_key]
    end

    def encode_params
      URI.encode_www_form(@query_params)
    end
  end
