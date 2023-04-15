Rails.application.routes.draw do
  get 'comments/create'
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :enrollments do
    get :my_students, on: :collection
    member do
      get :certificate
    end
  end

  resources :tags
  resources :courses do
    get :purchased, :pending_review, :created, :unapproved, :unpublished, :index_admin, on: :collection
    member do
      patch :approve, :unapprove, :publish, :unpublish
      get :analytics
    end
    resources :lessons, except: [:index] do
      resources :comments, except: [:index]
      member do
        delete :delete_video
      end
    end
    resources :enrollments, only: [:create, :new]
    resources :course_wizard, controller: 'courses/course_wizard'
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
