Rails.application.routes.draw do

  root :to => 'welcome#index'

  resources :welcome, only: [:index]

  resources :profile, only: [:show, :edit, :update] do
    resources :posts, only: [:index, :show, :new, :create, :update, :destroy]
  end

  # end

  # Devise
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' } do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

end
