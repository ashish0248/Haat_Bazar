module NotificationsHelper
	def notification_form(notification)
	    #通知を送ってきたユーザーを取得
	    @visitor = notification.visitor
	    #コメントの内容を通知に表示する
	    # notification.actionがfollowかchatかで処理を変える
	    case notification.action
	    when 'follow'
	    	#aタグで通知を作成したユーザーshowのリンクを作成
	    	tag.a(notification.visitor.name, href: user_path(@visitor)) + 'さんがあなたをフォローしました'
	    when 'chat'
	    	tag.a(notification.visitor.name, href: user_path(@visitor)) + 'さんがチャットであなたにメッセージを送りました'
	    end
	end
end
