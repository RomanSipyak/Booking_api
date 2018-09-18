class BooksController < ApplicationController
  before_action :authenticate_user, only: [:create, :update, :index, :destroy]

  # TEST :  Postman complite
  def update
    booking = Book.find(params[:id])
    if (booking.user = current_user)
      if booking.update(booking_params)
        render json: booking
      else
        render json: {errors: booking.errors}, status: :unprocessable_entity
      end
    else
      render json: {errors: "you can't do it"}, status: :unprocessable_entity
    end
  end

  # TEST :  Postman complite and rspec
  def destroy
    booking = Book.find(params[:id])
    if booking.user == current_user
      booking.destroy
      render json: {status: :ok}, status: :ok
    else
      render json: {errors: "you can't do it"}, status: :unprocessable_entity
    end
  end

  # TEST :  Postman complite
  def index
    if params[:item_id]
      render json: Book.where(item_id: params[:item_id])
    elsif params[:user_id]
      render json: Book.where(user_id: params[:user_id])
    else
      render status: :not_found
    end
  end

  # TEST :  Postman complite and rspec
  def create
    booking = Book.new(booking_params)
    item = Item.find(params[:item_id])

    booking.total_price = (booking.end_booking - booking.start_booking) * (item.price / 86_400)
    booking.item = item
    booking.user = current_user
    if booking.save
      render json: booking
    else
      render json: {errors: booking.errors}, status: :unprocessable_entity
    end
  end

  # TEST :  Postman complite  and rspec
  def show
    booking = Book.find(params[:id])
    render json: booking
  end

  private

  def booking_params
    params.require(:book).permit(:end_booking, :start_booking)
  end
end
