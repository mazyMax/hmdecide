Rails.application.routes.draw do
  devise_for :users
  #get 'home/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  get 'home/about'

    resources :users, only: [:show, :edit, :update]
    resources :posts, only: [:new, :create, :show, :destroy, :index]
    resources :choices do
        member do
            put 'like', to: 'choices#upvote'
            put 'unlike', to: 'choices#downvote'
        end
    end

    resources :posts do
        member do
            post 'change_to_public', to: 'posts#change_to_public'
            post 'change_to_private', to: 'posts#change_to_private'
            post 'change_who_can_see', to: 'posts#change_who_can_see'
        end
    end

    resources :users do
        member do
            put 'follow', to: 'users#follow'
            put 'unfollow', to: 'users#unfollow'
        end
    end
end
