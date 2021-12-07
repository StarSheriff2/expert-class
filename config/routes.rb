Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'cities/index'
    end
  end
  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do
      resources :users, only: [:create]
      resources :reservations, only: [:index, :show, :create, :destroy]
      resources :courses, only: [:index, :show, :create, :destroy]
      resources :cities, only: [:index]

      post :sign_in, to: 'sessions#create'
      delete :sign_out, to: "sessions#logout"
      get :signed_in, to: "sessions#logged_in"
    end
  end

  root to: "api/v1/sessions#logged_in"
end
