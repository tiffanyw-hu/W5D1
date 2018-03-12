Rails.application.routes.draw do

  resources :users, only: [ :new, :create ]
  get '/', to: 'users#new', as: 'root'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
