class ItemsController < ApplicationController

	def create
		@item = Item.new(item_params)
		@item.save

		# 非同期用
		@items = Item.where(document_id: @item.document_id)
  		@item_new = Item.new(document_id: @item.document_id)
	end

	def destroy
		@item = Item.find(params[:id])
		document_id = @item.document_id
		@item.destroy

		# 非同期用
		@items = Item.where(document_id: @item.document_id)
  		@item_new = Item.new(document_id: @item.document_id)
	end

	def edit
		@item = Item.find(params[:id])
	end

	def update
		@item = Item.find(params[:id])
		@item.update(item_params)
		redirect_to  edit_document_path(@item.document_id)
	end

	private

	 def item_params
     params.require(:item).permit(:document_id, :name, :price, :number, :unit)
  end
end
