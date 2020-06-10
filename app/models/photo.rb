class Photo < ApplicationRecord

  # 画像用
  attachment :photo_image

  #他のモデルとの関係
  belongs_to :user
  acts_as_list scope: :user

end
