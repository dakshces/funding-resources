Rails.application.routes.draw do
  root to: "pages#home"
  ActiveAdmin.routes(self)
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  as :user do
    get 'sign_in', :to => 'devise/sessions#new'
  end

  resources :resources
  resources :search, only: [:index]

  get '/contact', to:'pages#contact', as:'contact'
  get '/browse', to:'search#index', as:'browse'
  get 'resources/new', to:'resources#new', as:'add_funds'
  
end
