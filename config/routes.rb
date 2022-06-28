Rails.application.routes.draw do
  resources :plants
  get '/plants/:id/is_in_stock', to: 'plants#is_in_stock'
end
