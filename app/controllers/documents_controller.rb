class DocumentsController < ApplicationController
  def index

  end

  def new
  	@document_new = Document.new
  	@user = User.find(current_user.id)
    @following_users = @user.followings

  end

  def create
  	@document = Document.new(document_params)
  	user_id = @document.receiver_id
  	@user = User.find(user_id)
  	@document.maker_id = current_user.id
  	@document.maker_name = current_user.name
  	@document.maker_postal_code = current_user.postal_code
  	@document.maker_address = current_user.address
  	@document.maker_staff = current_user.staff
  	@document.maker_phone_number = current_user.phone_number

  	@document.receiver_id = @user.id
  	@document.receiver_name = @user.name
  	@document.receiver_postal_code = @user.postal_code
  	@document.receiver_address = @user.address
  	@document.receiver_staff = @user.staff
  	@document.receiver_phone_number = @user.phone_number

  	require "date"
  	@document.effective_date = Date.today

  	@document.save

  	redirect_to edit_document_path(@document.id)
  end

  def edit
  	@document = Document.find(params[:id])

  end

  def update
  end

  def show
  end

  private

  def document_params
     params.require(:document).permit(:document_status, :maker_id, :receiver_id, :maker_name, :maker_postal_code, :maker_address, :maker_staff, :maker_phone_number, :receiver_name, :receiver_postal_code, :receiver_address, :receiver_staff, :receiver_phone_number, :effective_date, :expiration_date, :postage, :receipt_number, :payee, :remark)
  end

end
