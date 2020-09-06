Rails.application.routes.draw do
  post 'friendships/:id/create_friend_request', to: 'friendships#create_friend_request'
  delete 'friendships/:id/delete_friend_request', to: 'friendships#delete_friend_request'
  post 'friendships/:id/accept_friend_request', to: 'friendships#accept_friend_request'
  delete 'friendships/:id/delete_friend', to: 'friendships#delete_friend'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'authenticate', to: 'authentication#authenticate'
  
  resources :users	
  root 'users#index'
  
  get 'me', to: 'users#me'
end
