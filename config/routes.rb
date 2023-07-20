Rails.application.routes.draw do
  resources :interactions
  resources :properties
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post    '/login'    => 'sessions#create'
  delete  '/logout'   => 'sessions#destroy'
  post    '/signup'   => 'users#create'

end
