class CreateChatRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :chat_rooms do |t|
      #間違えて作ったカラム
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
