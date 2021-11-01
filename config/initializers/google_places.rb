# frozen_string_literal: true
require './lib/google_places'

GooglePlaces.api_key = Rails.application.credentials.google_places_api
