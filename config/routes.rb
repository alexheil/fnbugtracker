Rails.application.routes.draw do

  root 'static_pages#home'

  devise_for :users, controllers: { sessions: "users/sessions", passwords: "users/passwords", registrations: "users/registrations", confirmations: "users/confirmations",  unlocks: "users/unlocks"}

  devise_scope :user do
    get 'sign_out', to: 'users/sessions#destroy', path: 'sign-out'
    get 'sign_in', to: 'users/sessions#new', path: 'sign-in'
    get 'register', to: 'users/registrations#new'
  end

  resources :users, controller: 'users/users', only: [:show, :update]

  resources :gamemodes, controller: 'gamemodes/gamemodes'
  resources :statuses, controller: 'statuses/statuses'
  resources :platforms, controller: 'platforms/platforms'

  resources :bugs, controller: 'bugs/bugs'

end
