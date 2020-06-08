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
end