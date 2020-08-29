Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
  resources :item, only:[:index, :new, :show, :edit]
end
