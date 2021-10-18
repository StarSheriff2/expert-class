Rails.application.routes.draw do
  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do
      resources :users, :cities, :reservations, :courses
      # get 'classes-list', to: 'classes#index'
    end
  end
end
