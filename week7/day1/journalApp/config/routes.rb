Rails.application.routes.draw do
  root to: "root#show"
  
  namespace :api, defaults: { format: :json} do
    resources :posts
  end
  
end
