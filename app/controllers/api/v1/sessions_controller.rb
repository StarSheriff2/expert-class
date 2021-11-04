class API::V1::SessionsController < ApplicationController
  # include CurrentUserConcern

  def create
    user = User.find_by(username: params['user']['username'])

    if user
      session[:_expert_class] = user.id
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
    session.delete(:_expert_class)
    @current_user = nil
    render json: {
      status: 200,
      logged_out: true
    }
  end
end
