class ItemsController < ApplicationController
  def new
    @item = Item.new
    render json: @item
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user
    if @item.save
      render json: @item
    else
      render json: { errors: @item.errors }, status: :unprocessable_entity
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      render json: @item
    else
      render json: { errors: @item.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    render status: :ok
  end

  def index
    if params[:filter]
      params[:by_title].strip!
      @items = Item.book_interval(container_time[:start_booking], container_time[:end_booking])
                   .filter(params.slice(%i[by_title by_city by_category]))
                   .where.not(user: current_user)
      render json: @items
    else
      @items = Item.where.not(user: current_user)
      render json: @items
    end
  end

  def my
    @items = Item.where(user: current_user)
    render json: @items
  end

  def show
    @item = Item.find(params[:id])
    render json: @item
  end

  private

  def item_params
    params.require(:item).permit(:description, :category_id, :price, :image)
  end

  def container_time
    start_booking = DateTime.new(params[:filter][:start_booking])
    end_booking = DateTime.new(params[:filter][:end_booking])
    { start_booking: start_booking, end_booking: end_booking }
  end
end
