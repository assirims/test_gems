Rails.application.routes.draw do
  # get 'static_pages/landing_page'
  # get 'static_pages/privacy_policy'
  match '/privacy', to: 'static_pages#privacy_policy', via: 'get'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "static_pages#landing_page"
end
