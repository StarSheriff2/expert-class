class API::V1::ReservationsController < ApplicationController
  include CurrentUserConcern

  def index
    @user_reservation = Reservation.all
    
    if @user_reservation
      render json: @user_reservation
    else
      render json: { status: 401 }
    end
  end
end
