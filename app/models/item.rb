class Item < ApplicationRecord

 	##モデル同士の関係
	belongs_to :document

	#バリデーション
	validates :document_id, presence: true
  	validates :name, presence: true
	validates :price, presence: true
  	validates :number, presence: true
  	validates :unit, presence: true
end
