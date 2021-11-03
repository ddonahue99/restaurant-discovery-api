require 'httparty'
require 'oj'

  module FindPlace
    include HTTParty

    FIND_PLACE_URL = '/place/findplacefromtext/json?'.freeze
    FIELDS = ['name', 'photo', 'geometry']

    # Call find_places endpoints
    #
    # @return [Hash]
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
      unless keyword
        raise StandardError.new('No keyword provided.')
      end

      @query_params << ["input", keyword]
      @query_params << ["inputtype", "textquery"]
    end

    def construct_location(location)
      return nil unless %i[:south :west :north :east].all? {|s| location.key? s}
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
