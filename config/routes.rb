Rails.application.routes.draw do
  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do
      resources :user, :cities, :reservations, :courses
    end
  end
end
