Rails.application.routes.draw do

  root :to => 'welcome#index'

  resources :welcome, only: [:index]

  resources :profile, only: [:show, :edit, :update] do
    resources :posts, only: [:new, :create, :update, :destroy] do
      member do
        post :on_like_clicked
      end
    end
  end

  # Devise
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' } do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

end
