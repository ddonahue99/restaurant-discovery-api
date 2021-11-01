require 'lib/api/google_places'

class SearchController < ApplicationController
  before_action :authenticate_user!

  def create
  end
end
