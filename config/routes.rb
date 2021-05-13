Rails.application.routes.draw do
  root to: "pages#home"
  ActiveAdmin.routes(self)
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :resources
  resources :search, only: [:index]

  get'/contact', to:'pages#contact', as:'contact'
  get '/browse', to:'search#index', as:'browse'
<<<<<<< HEAD
  get 'resources/new', to:'resources#new', as:'add_funds'
=======
  # get 'resources/new', to:'resources#new', as:'add_funds'
  # get 'resources/new', to:'resources#new', as:'new_resource'
  get '/add_funds', to:'pages#add_funds', as:'add_funds'
>>>>>>> 7c2ae593e90a22f2744e62c046f84cac91ea0c89
  
end
