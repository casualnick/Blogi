Rails.application.routes.draw do
  
  post "/login", to: 'sessions#create'

  get "/login", to: 'sessions#new'

  delete "/logout", to: 'sessions#destroy'

  resources :users 
end
