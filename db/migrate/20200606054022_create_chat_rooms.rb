class CreateChatRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :chat_rooms do |t|
      #belongなどの関係がないのでreferenceで明記
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
