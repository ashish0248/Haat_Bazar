Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => {
  :registrations => 'users/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #homesコントローラー
  resources :homes, only: [:new, :index]
  get '/' => 'homes#top', as: 'root'
  get 'homes/search'
  get 'homes/about'

  #usersコントローラー
  resources :users
  get 'users/leave'

  #photosコントローラー
  resources :photos, only: [:create, :edit, :update, :destroy]

  #chat_roomsコントローラー
  resources :chat_rooms, only: [:index, :show, :create]

  #chat_messagesコントローラー
  resources :chat_messages, only: [:show,:create]

  #relationshipsコントローラー
  resources :relationships, only: [:index, :create, :destroy]

  #notificationコントローラー
  resources :notifications, only: [:index, :destroy]

  #contactsコントローラー
  resources :contacts, only: [:new, :create]
end
