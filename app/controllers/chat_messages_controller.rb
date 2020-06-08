class ChatMessagesController < ApplicationController

	def show
		@user=User.find(params[:id])
		#current_user.chat_roomモデルのroom_idカラムの中身を全て取ってくる
		room_ids = current_user.chat_entrances.pluck(:chat_room_id)
		#user_idが「@user.id」でなおかつ,room_idが「rooms」の最初のレコードを取得
		user_rooms = ChatEntrance.find_by(user_id: @user.id, chat_room_id: room_ids)

		unless user_rooms.nil?
			#user_roomsが存在する場合
	  		@chat_room = user_rooms.chat_room
	  	else
	  		#存在しないのでルームとエントリーを作る
	  		@chat_room = ChatRoom.new
	  		@chat_room.save
	  		ChatEntrance.create(user_id: current_user.id, chat_room_id: @chat_room.id)
	  		ChatEntrance.create(user_id: @user.id, chat_room_id: @chat_room.id)
	  	end
	  	#すでにあるメッセージの取得
	  	@chat_messages = ChatMessage.where(chat_room_id: @chat_room.id)

	  	#投稿用
	  	@chat_message_new = ChatMessage.new(chat_room_id: @chat_room.id)
	end

	def create
		@chat_message = ChatMessage.new(chat_params)
		@chat_message.user_id = current_user.id
		@chat_message.save

		# 非同期用のパラメーター
		room_id = @chat_message.chat_room_id
		@chat_messages = ChatMessage.where(chat_room_id: room_id)
		@chat_message_new = ChatMessage.new(chat_room_id: room_id)
	end

	private

	def chat_params
		params.require(:chat_message).permit(:chat_room_id, :message, :chat_image)
	end
end
