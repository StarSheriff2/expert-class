class ApplicationController < ActionController::API
  # before_action :set_csrf_cookie

  include ActionController::Cookies
  include ActionController::RequestForgeryProtection
  protect_from_forgery with: :exception
  # skip_before_action :verify_authenticity_token

  include Response
  include ExceptionHandler

  before_action :set_current_user

  private

  def set_current_user
    @current_user = User.find(session[:user_id]) if session[:user_id]
  end

  # def cookie
  #   'ok'
  # end

  # private

  # def set_csrf_cookie
  #   cookies['CSRF-TOKEN'] = {
  #     value: form_authenticity_token,
  #     # domain: 'expert-class-backend.herokuapp.com',
  #     domain: %w[expert-class-backend.herokuapp.com expert-class-frontend-v2.netlify.app],
  #     # domain: 'expert-class-frontend-v2.netlify.app',
  #     #========= Production Setup for Heroku ==============#
  #     same_site: :None,
  #     secure: true
  #   }
  # end
end
