NinetyNineCats::Application.routes.draw do
  resources :cats do
    resources :cat_rental_requests, only: [:index]
  end
  
  resources :cat_rental_requests, only: [:new, :create, :destroy, :show] do
    member do
      patch :approve, action: 'approve'
      patch :deny, action: 'deny'
    end
  end
  
  resources :users, only: [ :new, :create ]
  resource :session, only: [ :new, :create, :destroy ]
end
