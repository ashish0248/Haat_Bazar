class Document < ApplicationRecord
  
 	##モデル同士の関係
 	has_many :items
	belongs_to :maker, class_name: 'User', :foreign_key => 'maker_id'
	belongs_to :receiver, class_name: 'User', :foreign_key => 'receiver_id'

	#バリデーション
	validates :document_status, presence: true


	def self.search1(keyword)
    	where(['receipt_number LIKE ? OR receiver_name LIKE ? OR effective_date LIKE ?', "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"])
	end

	def self.search2(keyword)
    	where(['receipt_number LIKE ? OR maker_name LIKE ? OR effective_date LIKE ?', "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"])
	end

end
