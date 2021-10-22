class ApplicationController < ActionController::API
  before_action :set_csrf_cookie

  include ActionController::Cookies
  include ActionController::RequestForgeryProtection

  protect_from_forgery with: :exception

  include Response
  include ExceptionHandler

  def cookie
    'ok'
  end

  private

  def set_csrf_cookie
    cookies['CSRF-TOKEN'] = {
      value: form_authenticity_token,
      domain: :all
    }
  end
end
