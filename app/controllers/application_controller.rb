class ApplicationController < ActionController::API
  include ActionController::Cookies
  include ActionController::RequestForgeryProtection
  include Response
  include ExceptionHandler

  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token
  before_action :set_current_user

  private

  def set_current_user
    @current_user = User.find(session[:user_id]) if session[:user_id]
  end
end
