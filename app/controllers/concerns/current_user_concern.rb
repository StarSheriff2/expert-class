module CurrentUserConcern
  extend ActiveSupport::Concern

  included do
    before_action :set_current_user
  end

  def set_current_user
    @current_user = User.find(session[:_expert_class]) if session[:_expert_class]
  end
end
