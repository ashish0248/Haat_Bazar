class ChatMessage < ApplicationRecord
  
  # 画像用
  attachment :chat_image

  #他のモデルとの関係
  belongs_to :user
  belongs_to :chat_room
  has_many :notifications, dependent: :destroy
end
