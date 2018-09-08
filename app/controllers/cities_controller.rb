class CitiesController < ApplicationController
  def new
  end

  def create
  end

  def update
  end

  def edit
  end

  def destroy
  end

  def index
    cities = city.all
    render json: cities
  end

  def show
  end
end
