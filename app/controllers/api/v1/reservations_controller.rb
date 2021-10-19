class API::V1::ReservationsController < ApplicationController
  def index
    Reservation.create!({ date: '12-09-2021', user_id: 1, course_id: 1, city_id: 1 })
    @user_reservation = Reservation.where(user_id: 1)
    render json: @user_reservation
  end
end
