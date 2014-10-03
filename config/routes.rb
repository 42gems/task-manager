Rails.application.routes.draw do
  
  root to: 'projects#index'
  
  devise_for :users

  resources :projects, only: [:index, :create, :destroy] do
    resources :tasks do
      resources :comments, only: []
    end
  end    
end
