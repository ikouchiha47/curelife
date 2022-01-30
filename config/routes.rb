Rails.application.routes.draw do
  # use_doorkeeper
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "homepage#index"

  get '/users/logout', to: 'users#logout'
  
  namespace :patients do
    get '/login',  to: 'patients#login'
    get '/signup', to: 'patients#signup'
    post '/login', to: 'patients#authenticate'
    post '/signup', to: 'patients#create'
    get '/show', to: 'users#show'
  end

  namespace :clients do
    get '/login',  to: 'clients#login'
    get '/signup', to: 'clients#signup'
    post '/login', to: 'clients#authenticate'
    post '/signup', to: 'clients#create'
    get '/show', to: 'users#show'
  end

  get '/services', to: 'bookings#services'

  resources :users, only: [] do
    resources :bookings
  end

  resources :doctors, only: %i[index show]


  resources :bookings, only: [] do
    get '/ambulances', to: 'ambulances#new'
    post '/ambulances', to: 'ambulances#create'
    delete '/ambulance/:id', to: 'ambulances#delete'

    get '/appointments', to: 'appointments#new'
    post '/appointments', to: 'appointments#create'
    delete '/appointments/:id', to: 'appointments#delete', as: 'appointments_delete'

    get '/lab_test', to: 'lab_tests#new'
    post '/lab_test', to: 'lab_tests#create'
    delete '/lab_test/:id', to: 'lab_tests#delete'
  end
end
