Rails.application.routes.draw do
  
  root to: 'projects#index'
  devise_for :users

  resources :projects do
    resources :tasks do
      resources :comments, only: []
    end
    post   'send_invite/:id',   to: 'projects#send_invite',   as: 'send_invite'
    get    'add_member/:id',    to: 'projects#add_member',    as: 'add_member'
    delete 'remove_member/:id', to: 'projects#remove_member', as: 'remove_member'
  end
end
