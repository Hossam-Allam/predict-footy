Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  namespace :my do
    resources :leagues, only: [ :index, :show, :new, :create ]
  end

  root "matches#index"
end
