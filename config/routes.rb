Rails.application.routes.draw do
  # use_doorkeeper
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "homepage#index"

  get '/users/logout', to: "users#logout"
  
  namespace :patients do
    get '/login',  to: "patients#login"
    get '/signup', to: "patients#signup"
    post '/login', to: "patients#authenticate"
    post '/signup', to: "patients#create"
    get '/show', to: "users#show"
  end

  namespace :clients do
    get '/login',  to: "clients#login"
    get '/signup', to: "clients#signup"
    post '/login', to: "clients#authenticate"
    post '/signup', to: "clients#create"
    get '/show', to: "users#show"
  end

  get '/services', to: "bookings#services"
  
  resources :users, only: [] do
    resources :bookings
  end

  resources :bookings, only: [] do
    get '/ambulance', to: "bookings#new_ambulance"
    post '/ambulance', to: "bookings#create_ambulance"

    get '/appointment', to: "bookings#new_appointment"
    post '/appointment', to: "bookings#create_appointment"

    get '/labtest', to: "bookings#new_labtest"
    post '/labtest', to: "bookings#create_labtest"
  end
end
