require 'httparty'
  module FindPlace
    FIND_PLACE_URL = '/place/findplacefromtext/json?'
    include HTTParty

    def find_place(keyword, location)
      # add name, location, photo
      api_url = [@base_url, FIND_PLACE_URL, construct_textquery(keyword), construct_location(location), construct_key].join()
      HTTParty.get(ERB::Util.url_encode(api_url))
    end

    def construct_textquery(keyword)
      # raise here instead?
      "input=#{keyword}&inputtype=textquery"
    end

    def construct_location(location)
      return nil unless location.class == Hash
      "&locationbias=rectangle:#{location[:south]}, #{location[:west]} | #{location[:north]}, #{location[:east]}"
    end

    def construct_key
      "&key=#{GooglePlaces.api_key}"
    end
  end
