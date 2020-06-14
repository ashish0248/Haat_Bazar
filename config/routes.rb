Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => {
  :registrations => 'users/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #homesコントローラー
  resources :homes, only: [:new, :index, :create]
  get '/' => 'homes#top', as: 'root'
  get 'homes/search'
  get 'homes/about'

  #usersコントローラー
  get 'users/leave'
  resources :users
  patch 'users/:id/sort', to: 'users#sort',  as: 'user_sort'


  #photosコントローラー
  resources :photos, only: [:create, :edit, :update, :destroy]

  #chat_messagesコントローラー
  resources :chat_messages, only: [:index, :show,:create]

  #relationshipsコントローラー
  resources :relationships, only: [:index, :create, :destroy]

  #notificationコントローラー
  resources :notifications, only: [:index, :destroy]

  #contactsコントローラー
  resources :contacts, only: [:new, :create]
end
