Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  resources :courses
  resources :users, only: [:index]

  get 'home/activity'
  match '/privacy', to: 'home#privacy_policy', via: 'get'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
end
