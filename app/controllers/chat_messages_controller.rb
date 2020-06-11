class ChatMessagesController < ApplicationController
	# チャットルーム一覧
	def index
		#フォローしている人＝チャット可能な人
		@users = current_user.followings

		@not_users = current_user.followers
	end

	# チャットルーム
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
	  	# 10件ずつ増やす
	  	if params[:count]
	  		@count = params[:count]
	  		@count = @count.to_i + 10
	  		@chat_messages = ChatMessage.where(chat_room_id: @chat_room.id).last(@count)
	  	else
	  		# 最初は10件表示
	  		@count = 10
	  		@chat_messages = ChatMessage.where(chat_room_id: @chat_room.id).last(@count)
	  	end

	  	#投稿用
	  	@chat_message_new = ChatMessage.new(chat_room_id: @chat_room.id)
	end

	def create
		@chat_message = ChatMessage.new(chat_params)
		# 通知機能用にチャットを送られる人を取得
		@user_id = @chat_message.user_id

		@chat_message.user_id = current_user.id

		if @chat_message.save
			# メッセージが送られた人に通知
			@user = User.find(@user_id)
      		@user.create_notification_chat!(current_user)
      	else
      		redirect_back(fallback_location: root_path)
		end
		# 非同期用のパラメーター
		room_id = @chat_message.chat_room_id
		@chat_messages = ChatMessage.where(chat_room_id: room_id)
		@chat_message_new = ChatMessage.new(chat_room_id: room_id)
	end

	private

	def chat_params
		params.require(:chat_message).permit(:chat_room_id, :message, :chat_image, :user_id)
	end
end
