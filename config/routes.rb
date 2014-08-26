NinetyNineCats::Application.routes.draw do
  resources :cats do
    resources :cat_rental_requests, only: [:index]
  end
  
  resources :cat_rental_requests, only: [:new, :create, :destroy, :show]
end
