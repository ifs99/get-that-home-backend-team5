Rails.application.routes.draw do

  resources :properties
  resources :users
  resources :properties do
    resources :interactions, only: [:create]
  end
  delete '/properties/:property_id/interaction' => 'interactions#delete_interaction'
  patch '/properties/:property_id/interaction' => 'interactions#update_interaction'
  get '/interactions' => 'interactions#index_interactions'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post    '/login'    => 'sessions#create'
  delete  '/logout'   => 'sessions#destroy'
  post    '/signup'   => 'users#create'

end
