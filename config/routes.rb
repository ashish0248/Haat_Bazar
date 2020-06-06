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

  #chat_roomsコントローラー
  resources :chat_rooms, only: [:index, :show, :create]

  #chat_messagesコントローラー
  resources :chat_massages, only: [:create]

  #relationshipsコントローラー
  resources :relationships, only: [:new, :index, :create, :destroy]

end
