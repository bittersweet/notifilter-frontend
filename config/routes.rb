Rails.application.routes.draw do
  root "notifiers#index"

  resources :notifiers
end
