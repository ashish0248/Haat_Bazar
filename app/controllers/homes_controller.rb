class HomesController < ApplicationController
  # トップページ
  def top
    @user = User.where(user_status: true)
  	@user_makers = @user.where(user_maker: true)
  	@user_shops = @user.where(user_maker: false)
  end

  # ユーザー一覧ページ
  def index
    @user = User.where(user_status: true)
    @user_makers = @user.where(user_maker: true)
    @user_shops = @user.where(user_maker: false)
  	# タグ検索
  	if params[:tag_name]
      @users = User.tagged_with("#{params[:tag_name]}")
      @user_makers = @users.where(user_maker: true)
      @user_shops = @users.where(user_maker: false)
    end
    if @keyword = params[:keyword]
      @searched_users = User.search(params[:keyword])
      @user_makers = @searched_users.where(user_maker: true)
      @user_shops  = @searched_users.where(user_maker: false)
    end
  end

  def about
  end

  ##お問い合わせフォーム
  def new
    @contact_new = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      # メールで送信
      ContactMailer.send_mail(@contact).deliver unless @contact.invalid?
      redirect_to root_path
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:message, :name, :email)
  end
end
