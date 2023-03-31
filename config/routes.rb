Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :enrollments do
    get :my_students, on: :collection
  end

  resources :courses do
    get :purchased, :pending_review, :created, on: :collection
    resources :lessons
    resources :enrollments, only: [:create, :new]
  end

  resources :users, only: [:index , :edit, :show, :update, :destroy]

  get 'activity', to: 'home#activity'
  get 'analytics', to: 'home#analytics'
  match '/privacy', to: 'home#privacy_policy', via: 'get'

  root "home#index"
end
