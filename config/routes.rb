Rails.application.routes.draw do
  get "pages/about"
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  namespace :my do
    resources :leagues, only: [ :index, :show, :new, :create ] do
      collection do
        post "join", to: "leagues#join", as: :join_league
      end
    end
    resources :predictions, only: [ :index, :show ]
  end

  resources :matches, only: [ :index, :show ] do
    resources :predictions, only: [ :new, :create, :update ]
  end

  root "matches#index"
end
