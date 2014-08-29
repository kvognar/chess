Rails.application.routes.draw do

  resource :session, only: [:new, :create, :destroy]
  
  resources :users, only: [:new, :create]
  
  resources :subs, except: :destroy do
    member do
      resources :posts, only: [:new]
    end
  end
  
  resources :posts, only: [:show, :create, :edit, :update]
end
