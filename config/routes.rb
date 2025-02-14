Rails.application.routes.draw do
  devise_for :users
  # OAuth callback route (handled by SessionsController)
  get "/auth/github/callback", to: "sessions#create"

  # Root path (handled by WelcomeController)
  root "welcome#index"
end
