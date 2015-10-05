Rails.application.routes.draw do
  root "notifiers#index"

  resources :notifiers
  resources :events, only: [:index]
end
