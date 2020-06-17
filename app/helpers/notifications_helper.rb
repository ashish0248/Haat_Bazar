module NotificationsHelper
	def notification_form(notification)
	    #通知を送ってきたユーザーを取得
	    @visitor = notification.visitor
	    #コメントの内容を通知に表示する
	    # notification.actionがfollowかchatかphotoかで処理を変える
	    case notification.action
	    when 'follow'
	    	notification.visitor.name + 'さんがあなたをフォローしました'
	    when 'chat'
	    	notification.visitor.name + 'さんがチャットであなたにメッセージを送りました'
	    when 'photo'
	    	notification.visitor.name + 'さんが写真を新たに投稿しました'
	    end
	end

	def unchecked_notifications
    	@notifications = current_user.passive_notifications.where(checked: false)
	end
end
