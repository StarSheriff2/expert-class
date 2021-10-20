class API::V1::ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[index show]

  def index
    render json: @user_reservations
  end

  def show
    render json: @reservation
  end

  private

  def set_reservation
    @user_reservations = Reservation.where(user_id: rand(2)) # add @current_user
    @reservation = Reservation.find_by(id: params[:id])
  end
end
