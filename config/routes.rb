Rails.application.routes.draw do
  resources :kids
  root 'homes#top'
  get 'users/account' => 'users#account' #設定/アカウント画面

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
