Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :enrollments do
    get :my_students, on: :collection
  end

  resources :courses do
    get :purchased, :pending_review, :created, :unapproved, :unpublished, :index_admin, on: :collection
    member do
      get :approve, :unapprove, :publish, :unpublish
    end
    resources :lessons
    resources :enrollments, only: [:create, :new]
  end

  resources :users, only: [:index , :edit, :show, :update, :destroy]

  get 'activity', to: 'home#activity'
  get 'analytics', to: 'home#analytics'
  match '/privacy', to: 'home#privacy_policy', via: 'get'

  namespace :charts do
    get 'users_per_day'
    get 'enrollments_per_day'
    get 'course_popularity'
    get 'money_makers'
  end

  root "home#index"
end
