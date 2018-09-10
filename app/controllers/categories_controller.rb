class CategoriesController < ApplicationController

  def create
  end

  def update
  end


  def destroy
  end

  def index
    categories = Category.all
    render json: categories
  end

  def show
  end
end
