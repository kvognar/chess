Rails.application.routes.draw do
  
  

  resource :session, only: [:new, :create, :destroy]
  
  resources :users, only: [:new, :create]
  
  resources :subs, except: :destroy do
    member do
      resources :posts, only: [:new]
    end
  end
  
  resources :posts, only: [:show, :create, :edit, :update] do
    member do
      post 'upvote', to: 'posts#upvote', as: 'upvote'    
      post 'downvote', to: 'posts#downvote', as: 'downvote'
    end
  end
  
  
  resources :comments, only: [:create] do
    member do
     post 'upvote', to: 'comments#upvote', as: 'upvote'
     post 'downvote', to: 'comments#downvote', as: 'downvote' 
    end
  end
  
  root to: 'subs#index'
  
end
