class API::V1::SessionsController < ApplicationController
  # include CurrentUserConcern
  before_action :set_csrf_cookie, only: %i[csrf_token]

  def csrf_token
    render json: { status: :created }, status: 200
  end

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

  private

  def set_csrf_cookie
    cookies['CSRF-TOKEN'] = {
      value: form_authenticity_token,
      domain: 'expert-class-backend.herokuapp.com',
      # domain: %w[expert-class-backend.herokuapp.com expert-class-frontend-v2.netlify.app],
      # domain: 'expert-class-frontend-v2.netlify.app',
      #========= Production Setup for Heroku ==============#
      same_site: :None,
      secure: true
    }
  end
end
