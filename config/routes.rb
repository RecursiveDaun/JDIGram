Rails.application.routes.draw do

  mount ActionCable.server => '/cable'

  root :to => 'welcome#index'
  get 'search', to: 'search#search'

  resources :welcome, only: [:index]
  resources :user_profile, only: [:new, :show, :edit, :update] do
    post 'follow_unfollow', to: 'user_profile#follow_unfollow'
    get 'friends', to: 'user_profile#friends'
  end
  resources :posts, only: [:new, :create, :update, :destroy] do
    member do
      get :on_like_clicked
      post :add_comment
    end
  end

  resources :conversation, only: [:create, :index, :show] do
    resources :message, only: [:create]
  end
  
  # Devise
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' } do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

end
