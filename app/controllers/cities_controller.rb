class CitiesController < ApplicationController

  def index
    cities = city.all
    render json: cities
  end

end
