NinetyNineCats::Application.routes.draw do
  resources :cats do
    resources :cat_rental_requests, only: [:index]
  end
  
  resources :cat_rental_requests, only: [:new, :create, :destroy, :show] do
    patch :approve, action: 'approve'
    patch :deny, action: 'deny'
  end
end
