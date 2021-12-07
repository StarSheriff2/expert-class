class API::V1::ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[index destroy]

  def index
    @user_reservations = @user_reservations.map do |reservation|
      {
        user: User.find(reservation.user_id).name,
        course: Course.find(reservation.course_id).title,
        city: City.find(reservation.city_id).name,
        date: reservation.date,
        id: reservation.id,
        created_at: reservation.created_at,
        updated_at: reservation.updated_at
      }
    end
    json_response(@user_reservations)
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.date = @reservation.date.to_datetime

    if @reservation.save
      render json: {
        reservation: {
          user: User.find(@reservation.user_id).name,
          course: Course.find(@reservation.course_id).title,
          city: City.find(@reservation.city_id).name,
          date: @reservation.date,
          id: @reservation.id,
          created_at: @reservation.created_at,
          updated_at: @reservation.updated_at
        },
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
    @user_reservations = Reservation.where(user_id: current_user.id)
  end

  def reservation_params
    params.require(:reservation).permit(:date, :user_id, :course_id, :city_id)
  end
end
