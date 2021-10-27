class API::V1::CitiesController < ApplicationController
  before_action :set_cities

  def index
    json_response(@cities)
  end

  private

  def set_cities
    @cities = City.all
  end
end
