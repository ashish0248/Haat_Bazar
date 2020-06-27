class ChatMessage < ApplicationRecord
  
  # 画像用
  attachment :chat_image

  #他のモデルとの関係
  belongs_to :user
  belongs_to :chat_room
  has_many :notifications, dependent: :destroy

   #バリデーション
  validates :user_id, presence: true
  validates :chat_room_id, presence: true
   # messageが空ならば、chat_image_idを必須にする
  validates :message, presence: true, unless: :chat_image, presence: true
  # chat_image_idが空ならば、messageを必須にする
  validates :chat_image, presence: true, unless: :message?

end
