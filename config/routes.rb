Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do
      resources :users, only: [:create]
      resources :reservations, only: [:index, :create, :destroy]
      resources :courses, only: [:index, :show, :create, :destroy]
      resources :cities, only: [:index]

      post :sign_in, to: 'sessions#create'
      delete :sign_out, to: "sessions#logout"
      get :signed_in, to: "sessions#logged_in"
      get '/healthcheck', to: proc { [200, {}, ['success']] }
    end
  end

  root to: "api/v1/sessions#logged_in"
end
