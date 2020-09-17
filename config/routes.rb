Rails.application.routes.draw do
  
  get "/home", to: 'posts#index'

  post "/login", to: 'sessions#create'

  get "/login", to: 'sessions#new'

  delete "/logout", to: 'sessions#destroy'

  resources :users  do
    resources :posts
  end
  
end
