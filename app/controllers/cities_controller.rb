class CitiesController < ApplicationController


  def create
  end

  def update
  end

  def destroy
  end

  def show
  end

  def index
    cities = city.all
    render json: cities
  end


end
