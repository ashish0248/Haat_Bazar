class ChatRoom < ApplicationRecord

  has_many :chat_messages, dependent: :destroy
  has_many :chat_entrances, dependent: :destroy

end