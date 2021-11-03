require 'httparty'
require 'oj'
require './lib/apis/google_places/errors'

  module FindPlace
    include HTTParty

    FIND_PLACE_URL = '/place/findplacefromtext/json?'.freeze
    FIELDS = ['name', 'photo', 'geometry']

    # Call find_places endpoints
    #
    # @param keyword [String] for text query
    # @param location [Hash] of N/E/S/W coordinates for rectangle
    # @return [Hash]
    # @see https://developers.google.com/maps/documentation/places/web-service/search-find-place
    def find_place(keyword, location={})
      url = build_url(keyword, location)
      HTTParty.get(url).parsed_response
    end

    private

    def build_url(keyword, location)
      construct_textquery(keyword)
      construct_location(location)
      construct_fields
      api_url = [base_url, FIND_PLACE_URL, encode_params(), construct_key].join()
    end

    def construct_textquery(keyword)
      raise FindPlaceAPIError.new('No keyword provided.') if keyword.blank?

      @query_params << ["input", keyword]
      @query_params << ["inputtype", "textquery"]
    end

    def construct_location(location)
      debugger
      raise FindPlaceAPIError.new('Rectangle geometry invalid.') unless %i[:south :west :north :east].all? {|s| location.key? s}
      @query_params << ["locationbias", "rectangle:#{location[:south]},#{location[:west]}|#{location[:north]},#{location[:east]}"]
    end

    def construct_fields
      @query_params << ["fields", FIELDS.join(',').to_s]
    end

    def construct_key
      "&key=#{GooglePlaces.api_key}"
    end

    def encode_params
      URI.encode_www_form(@query_params)
    end
  end
