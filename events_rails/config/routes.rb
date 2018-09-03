Rails.application.routes.draw do
  resources :events, only: [:index, :show, :create, :destroy]
  resources :organizers , only: [:index, :show, :create, :destroy]
end
