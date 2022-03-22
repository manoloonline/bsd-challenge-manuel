Rails.application.routes.draw do
  devise_for :users
  
  get 'twitch/search'
  post 'twitch/search'
  get 'twitch/lucky'
  post 'twitch/lucky'
  
  namespace :api do
    get 'greetings/hello' 
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "twitch#search"
end
