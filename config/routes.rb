Rails.application.routes.draw do
  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do
      resources :users, :cities, :reservations, :courses
      # get 'classes-list', to: 'classes#index'
      resources :sessions, only: [:create]
      # resources :users

      post :sign_in, to: 'sessions#create'
      delete :sign_out, to: "sessions#logout"
      get :signed_in, to: "sessions#logged_in"
      
    end
  end
  
  root to: 'static#home'
end
