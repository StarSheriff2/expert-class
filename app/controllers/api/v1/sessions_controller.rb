class API::V1::SessionsController < ApplicationController
  skip_before_action :logged_in_user, only: %i[create logged_in]

  def create
    user = User.find_by(username: params['user']['username'])

    if user
      session[:user_id] = user.id
      render json: {
        status: :created,
        logged_in: true,
        user: user
      }
    else
      render json: { status: 401 }
    end
  end

  def logged_in
    if @current_user
      render json: {
        logged_in: true,
        user: @current_user
      }
    else
      render json: {
        logged_in: false
      }
    end
  end

  def logout
    session.delete(:user_id)
    @current_user = nil
    render json: {
      status: 200,
      logged_out: true
    }
  end
end
