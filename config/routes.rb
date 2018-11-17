Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:show, :update, :delete, :create]
  resources :goals, only: [:show, :create, :new]
  resource :session, only: [:destroy, :create, :new]
  
  
end
