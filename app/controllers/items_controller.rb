class ItemsController < ApplicationController

	def create
		@item = Item.new(item_params)
		@item.save

		# 非同期用のパラメーター
		@items = Item.where(document_id: @item.document_id)
  		@item_new = Item.new(document_id: @item.document_id)
	end

	def destroy
		@item = Item.find(params[:id])
		document_id = @item.document_id
		@item.destroy

		# 非同期用のパラメータ
		@items = Item.where(document_id: @item.document_id)
  		@item_new = Item.new(document_id: @item.document_id)
	end

	#編集画面
	def edit
		@item = Item.find(params[:id])
	end

	def update
		@item = Item.find(params[:id])
		@item.update(item_params)
		#書類の編集画面に戻る
		redirect_to  edit_document_path(@item.document_id)
	end

	private

	 def item_params
     params.require(:item).permit(:document_id, :name, :price, :number, :unit)
  end
end
