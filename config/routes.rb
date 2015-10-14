Rails.application.routes.draw do
  root "notifiers#index"

  get '/rules', to: 'notifiers#rules'
  post '/notifiers/:id', to: 'notifiers#update'#, via: [:get, :post, :options]
  get '/statistics', to: "statistics#overview"

  resources :notifiers
  resources :events, only: [:index, :show]
end
