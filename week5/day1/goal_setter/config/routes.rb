GoalSetter::Application.routes.draw do
  resources :users, :goals
  resource :session
end
