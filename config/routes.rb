Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  namespace :my do
    resources :leagues
  end

  root "matches#index"
end
