class DocumentsController < ApplicationController

  def index
    # 自分の制作した書類の新しい順
    @documents = Document.where(maker_id: current_user.id).order(created_at: :desc)
     # 自分受け取った書類の新しい順
    @received_documents = Document.where(receiver_id: current_user.id, send_status: true).order(created_at: :desc)
      #キーワード検索
    if @keyword = params[:keyword]
      @searched = Document.search1(params[:keyword])
      @documents = @searched.where(maker_id: current_user.id).order(created_at: :desc)
      
      @searched = Document.search2(params[:keyword])
      @received_documents = @searched.where(receiver_id: current_user.id, send_status: true).order(created_at: :desc)
    end
  end

   #書類の新規作成
  def new
  	@document = Document.new
  	@user = User.find(current_user.id)
    @following_users = @user.followings

  end

  #書類の作成と情報の移し替え
  def create
      @document = Document.new(document_params)
      @document.maker_id = current_user.id

    #バリデーションチェック
    if @document.save

      	user_id = @document.receiver_id
      	@user = User.find(user_id)
        #current_userの情報
      	@document.maker_name = current_user.name
      	@document.maker_postal_code = current_user.postal_code
      	@document.maker_address = current_user.address
      	@document.maker_staff = current_user.staff
      	@document.maker_phone_number = current_user.phone_number
        #receiverの情報
      	@document.receiver_id = @user.id
      	@document.receiver_name = @user.name
      	@document.receiver_postal_code = @user.postal_code
      	@document.receiver_address = @user.address
      	@document.receiver_staff = @user.staff
      	@document.receiver_phone_number = @user.phone_number

        #日付
      	require "date"
      	@document.effective_date = Date.today

      	@document.save
        #編集画面で編集を続ける
      	redirect_to edit_document_path(@document.id)
    else
        @user = User.find(current_user.id)
        @following_users = @user.followings
        render 'new'
    end
  end

  def edit
  	@document = Document.find(params[:id])
    
    #編集できるのは作った本人かつ未送信のものだけ
    if @document.maker_id == current_user.id and @document.send_status == false
      #別テーブルの商品の取得
    	@items = Item.where(document_id: @document.id)
    	@item_new = Item.new(document_id: @document.id)
    else
      redirect_to documents_path
    end
  end

  def update
  	@document = Document.find(params[:id])

    #送信するかどうか?
    if params[:status]
      #通知して更新
      @document.send_status = true
      @document.save
      user_id = @document.receiver_id
      @user = User.find(user_id)

      @user.create_notification_document!(current_user)

       #書類一覧画面へ
      redirect_to documents_path
    else
      #更新するのみ
      @document.update(document_params)
      redirect_to document_path(@document.id)
    end
  end

  def show
  	@document = Document.find(params[:id])
  	@items = Item.where(document_id: @document.id)

    #書類を作成した本人or受け取った人
    if @document.maker_id == current_user.id or @document.receiver_id == current_user.id
        respond_to do |format|
          format.html do
            render layout: 'layouts/show_layouts.html',
                   template: 'documents/show.html.erb',
                   encording: 'UTF-8'
          end
          #pdf化
          format.pdf do
            render pdf: "書類",
                   layout: 'layouts/pdf_layouts.html',
                   template: 'documents/show.html.erb',
                   encording: 'UTF-8',
                   page_size: 'A4'

          end
        end
    elsif @document.receiver_id == current_user.id and @document.send_status == true
      #書類を受信した人
        #pdf化
        respond_to do |format|
          format.html
          format.pdf do
            render pdf: "書類",
                   layout: 'layouts/pdf_layouts.html',
                   template: 'documents/show.html.erb',
                   encording: 'UTF-8',
                   page_size: 'A4'

          end
        end
    else
      redirect_to documents_path
    end
  end

  def destroy
    @document = Document.find(params[:id])
    @document.destroy
    redirect_to documents_path
  end

  private

  def document_params
     params.require(:document).permit(:document_status, :maker_id, :receiver_id, :maker_name, :maker_postal_code, :maker_address, :maker_staff, :maker_phone_number, :receiver_name, :receiver_postal_code, :receiver_address, :receiver_staff, :receiver_phone_number, :effective_date, :expiration_date, :postage, :receipt_number, :payee, :remark, :send_statu)
  end

end
