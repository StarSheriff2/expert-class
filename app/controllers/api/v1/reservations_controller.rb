class API::V1::ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[index show destroy]

  def index
    render json: @user_reservations
  end

  def show
    render json: @reservation
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.date = @reservation.date.to_datetime

    if @reservation.save
      render json: {
        message: 'Reservation created successfully',
        status: 200
      }
    else
      render json: {
        message: 'Create reservation failed',
        status: 400
      }
    end
  end

  def destroy
    if @reservation
      @reservation.destroy
      render json: { message: 'Reservation deleted successfully' }, status: 204
    else
      render json: { message: 'Delete reservation failed' }, status: 400
    end
  end

  private

  def set_reservation
    @user_reservations = Reservation.where(user_id: rand(2)) # add @current_user
    @reservation = Reservation.find_by(id: params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:date, :user_id, :course_id, :city_id)
  end
end
