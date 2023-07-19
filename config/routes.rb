Rails.application.routes.draw do
  resources :interactions
  resources :properties
  devise_for :users
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
 

  namespace :api do
    resources :properties, only: %i[index show]
  end
  namespace :api do
      devise_for :users, skip: :registrations, controllers: {
        sessions: 'api/sessions' # Controlador personalizado para sesiones
      }
  end

  namespace :api do
    resources :users, only: %i[index create]
  end
end
