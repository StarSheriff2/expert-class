class ApplicationController < ActionController::API
  include ActionController::Cookies
  include ActionController::RequestForgeryProtection
  include Response
  include ExceptionHandler

  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token
  before_action :logged_in_user

  private

  def current_user
    # @current_user = User.find(session[:user_id]) if session[:user_id]
    @current_user ||= session[:user_id] && User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def logged_in_user
    return if logged_in?

    render json: { error: 'You are not logged in. Please log in first.' }, status: 400
  end
end
