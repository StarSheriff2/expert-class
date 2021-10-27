Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'cities/index'
    end
  end
  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do
      resources :users, :reservations, :courses
      resources :cities, only: [:index]

      post :sign_in, to: 'sessions#create'
      delete :sign_out, to: "sessions#logout"
      get :signed_in, to: "sessions#logged_in"
    end
  end

  root to: "application#cookie"
end
