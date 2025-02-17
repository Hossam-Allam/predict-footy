Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  # Root path (handled by WelcomeController)
  root "matches#index"
end
