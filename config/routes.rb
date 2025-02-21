Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  namespace :my do
    resources :leagues, only: [ :index, :show, :new, :create ] do
      collection do
        post "join", to: "leagues#join", as: :join_league
      end
    end
  end

  resources :matches, only: [ :index, :show ] do
    resources :predictions, only: [ :new, :create, :edit, :update, :show ]
  end

  root "matches#index"
end
