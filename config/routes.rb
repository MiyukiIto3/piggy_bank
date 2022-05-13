Rails.application.routes.draw do
  resources :posts
  resources :kids
  root 'homes#top'
  get 'homes/select_kid' => 'homes#select_kid'
  get 'homes/select_type' => 'homes#select_type'
  get 'users/account' => 'users#account'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
