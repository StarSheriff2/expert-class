class API::V1::ReservationsController < ApplicationController
  include CurrentUserConcern

  def index
    @user_reservation =  @current_user.reservations.all
    render json: @user_reservation
  end
end
