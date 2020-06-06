class Notification < ApplicationRecord

  #他のモデルとの関係
  default_scope -> { order(created_at: :desc) }
  belongs_to :visitor, class_name: "User", optional: true
  belongs_to :visited, class_name: "User", optional: true
  belongs_to :chat_message, optional: true


  validates :visitor_id, presence: true
  validates :visited_id, presence: true
  ACTION_VALUES = ["follow", "chat"]
  validates :action,  presence: true, inclusion: {in:ACTION_VALUES}
  validates :checked, inclusion: {in: [true,false]}
end
