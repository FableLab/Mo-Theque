Rails.application.routes.draw do
  # For details on the DSL available within this file, see
  root to: 'pages#home'
  resources :users, only: [:new, :create, :show]
  resource :sessions, only: [:destroy, :new, :create]
end
