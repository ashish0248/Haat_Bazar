class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 画像用
  attachment :profile_image

  
  ##モデル同士の関係
  #photoモデル用
  has_many :photos, dependent: :destroy
  #フォロー機能用
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user
  #チャット機能用
  has_many :chat_messages, dependent: :destroy
  has_many :chat_entrances, dependent: :destroy
  #タグの使用
  acts_as_taggable
  #通知機能
  has_many :active_notifications, foreign_key:"visitor_id", class_name: "Notification", dependent: :destroy
  has_many :passive_notifications, foreign_key:"visited_id", class_name: "Notification", dependent: :destroy
  # ドラッグ・ドロップ用
  has_many :photos, -> { order(position: :asc) }
  #document用
  has_many :makers, class_name: 'Document', :foreign_key => 'maker_id'
  has_many :receivers, class_name: 'Document', :foreign_key => 'receiver_id'

  ## バリデーション
  validates :name, presence: true
  validates :staff, presence: true
  validates :introduction, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true
  validates :profile_image, presence: true

 #退会済みユーザーかどうか
   def active_for_authentication?
    super && (self.user_status == true)
   end

 
  def full_info
    if self.user_maker == true
      "作り手" + "　お名前:" + self.name + "　担当者:" + self.staff + "　住所:"+self.address
    else
      "お店" +"　お名前:" + self.name + "　担当者:" + self.staff + "　住所:"+self.address
    end
  end
  # フォロー機能用
  def follow(other_user)
    # 同一事物ではないか？
    unless self == other_user
      # 見つからなければ作る
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end
  
  def following?(other_user)
    self.followings.include?(other_user)
  end

  # フォロー関係の通知
  def create_notification_follow!(current_user)
    #すでに通知が作成されているか確認
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

  # チャット関係の通知
  def create_notification_chat!(current_user)
    #すでに通知が作成されているか確認
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'chat'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'chat'
      )
      notification.save if notification.valid?
    end
  end

  # Photo関係の通知
  def create_notification_photo!(current_user)
    #すでに通知が作成されているか確認
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'photo'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'photo'
      )
      notification.save if notification.valid?
    end
  end

    # document関係の通知
  def create_notification_document!(current_user)
    #すでに通知が作成されているか確認
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'document'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'document'
      )
      notification.save if notification.valid?
    end
  end

  # 検索用
  def self.search(keyword)
    where(['name LIKE ? OR introduction LIKE ? OR address LIKE ?', "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"])
 end
end
