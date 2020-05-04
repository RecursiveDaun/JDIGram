Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' } do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end
