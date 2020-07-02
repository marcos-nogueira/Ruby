Rails.application.routes.draw do
  resources :reports
  resources :orders
  resources :products

  get '/products?limit=num&page=num',  to: 'products#index'

  get 'reports?inicio=data&fim=data', to: 'reports#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html







end
