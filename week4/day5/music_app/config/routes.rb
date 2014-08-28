MusicApp::Application.routes.draw do
  resources :users, only: [:new, :create, :show]
  resources :bands do
    resources :albums, only: [:new]
  end
  
  resources :albums, except: [:new] do
    resources :tracks, only: [:new, :index]
  end
  
  resources :tracks do
    resources :notes, only: [:create]
  end
  
  resources :notes, only: :destroy
  
  resource :session, only: [:new, :create, :destroy]
  
  root to: 'bands#index'
end
