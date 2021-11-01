# frozen_string_literal: true

require 'httparty'
require 'apis/google_places/place_search'

module GooglePlaces
  class << self
    attr_accessor :api_key
  end
end
