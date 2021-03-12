Rails.application.routes.draw do
  devise_for :users
  #get 'home/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  get 'home/about'
    resources :users, only: [:show, :edit, :update]
    resources :posts, only: [:new, :create, :show, :destroy]
    
    resources :choices do
        member do
            put "Like" => "choices#upvote"
            put "Unlike" => "choices#downvote"
        end
    end
    resources :choices, only: [:new, :show, :create]
end
