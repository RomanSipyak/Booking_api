class ItemsController < ApplicationController
  # TODO :  Add a good status all
  before_action :authenticate_user, only: [:create, :my, :update, :index, :destroy]
  # TEST :  Postman complite and rspec
  def create
    item = Item.new(item_params)
    item.user = current_user
    if item.save
      render json: item
    else
      render json: {errors: item.errors}, status: :unprocessable_entity
    end
  end

  # TEST :  Postman complite and rspec
  def update
    item = Item.find(params[:id])
    if item.user == current_user
      if item.update(item_params)
        render json: item
      else
        render json: {errors: item.errors}, status: :unprocessable_entity
      end
    else
      render json: {errors: "you can't do it"}, status: :unprocessable_entity
    end
  end

  # TEST :  Postman complite and rspec
  def destroy
    item = Item.find(params[:id])
    if item.user == current_user
      item = Item.find(params[:id])
      item.destroy
      render json: {status: :ok}, status: :ok
    else
      render json: {errors: "you can't do it"}, status: :unprocessable_entity
    end
  end

  # TEST :  Postman complite and rspec. Filter not tested
  def index
    items = Item.all
    if params[:filter]
      params[:by_title].strip!
      items = items.book_interval(container_time[:start_booking], container_time[:end_booking])
                  .filter(params.slice(%i[by_title by_city by_category]))
    end
    items = items.where.not(user: current_user)
    render json: items
  end

  # TEST :  Postman complite and rspec. Filter not tested
  def index_all
    if params[:filter]
      params[:by_title].strip!
      items = Item.book_interval(container_time[:start_booking], container_time[:end_booking])
                  .filter(params.slice(%i[by_title by_city by_category]))
      render json: items
    else
      items = Item.all
      render json: items
    end
  end

  # TEST :  Postman complite and rspec.
  def my
    items = Item.where(user: current_user)
    render json: items
  end

  # TEST :  Postman complite and rspec.
  def show
    item = Item.find(params[:id])
    render json: item
  end

  private

  def item_params
    params.require(:item).permit(:description, :category_id, :price, :image, :name)
  end

  def container_time
    start_booking = DateTime.new(params[:filter][:start_booking])
    end_booking = DateTime.new(params[:filter][:end_booking])
    { start_booking: start_booking, end_booking: end_booking }
  end
end
