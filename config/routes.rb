Rails.application.routes.draw do
  resources :posts
  resources :kids
  root 'homes#top'

  get 'homes/select_kid' => 'homes#select_kid'
  get 'homes/select_type' => 'homes#select_type'
  get 'users/account' => 'users#account'

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
