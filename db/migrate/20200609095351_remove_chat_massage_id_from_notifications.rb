class RemoveChatMassageIdFromNotifications < ActiveRecord::Migration[5.2]
  def change
    remove_column :notifications, :chat_massage_id, :integer
  end
end
