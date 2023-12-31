Rails.application.routes.draw do

  #properties
  resources :properties
  resources :users
  resources :properties do
    resources :interactions, only: [:create]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # sessions
  post    '/login'    => 'sessions#create'
  delete  '/logout'   => 'sessions#destroy'

  # users
  post    '/signup'   => 'users#create'
  get     '/profile'  => 'users#show'

  # Home seeker interactions

  post    '/favorites/:id'   => 'interactions#create_favorite'
  patch    '/favorites/:id'   => 'interactions#update_favorite'
  delete '/favorites/:id'  => 'interactions#delete_favorite'
  get   '/favorites'   => 'interactions#index_favorite'
  get   '/interaction/:id'  => 'interactions#show_interaction'
  
  
  post '/contacted/:id' => 'interactions#create_contacted'
  get '/contacted' => 'interactions#index_contacted'

  # Landlord interactions
  get '/actived' => 'interactions#index_actived'
  patch  '/actived/:id' => 'interactions#update_actived'

  get '/closed' => 'interactions#index_closed'
  

end
