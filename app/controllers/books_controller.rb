class BooksController < ApplicationController
  def new
    booking = Booking.new(booking_params[:item_id])
    render json: booking
  end


  def update
    @booking = Book.find(params[:id])
    if @booking.update(booking_params)
      render json: @booking
    else
      render json: { errors: @booking.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @booking = Book.find(params[:id])
    @booking.destroy
  end

  def index
    if params[:item_id]
      render json: Booking.where(item_id: params[:item_id])
    elsif params[:item_id]
      render json: Booking.where(user_id: params[:user_id])
    else
      render status: :not_found
    end
  end

  def create
    @booking = Book.new(booking_params)
    @item = Item.find(params[:item_id])
    @booking.total_price = (@booking.end_booking - @booking.start_booking) * (@item.price / 86_400)
    @booking.item = @item
    @booking.user = current_user
    if booking.save
      render json: @booking
    else
      render json: { errors: @booking.errors }, status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:book).permit(:end_booking, :start_booking, :item_id, :user_id)
  end
end
