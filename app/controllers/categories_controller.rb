class CategoriesController < ApplicationController
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
    categories = Category.all
    render json: categories
  end

  def show
  end
end
