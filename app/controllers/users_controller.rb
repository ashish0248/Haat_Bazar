class UsersController < ApplicationController
  before_action :authenticate_user!
  # ユーザ情報表示ページ
  def index
    @user = current_user
  end

  # 自己紹介ページ
  def show
    @user = User.find(params[:id])
    @photos = Photo.where(user_id: @user.id)
    @photo_new = Photo.new

    # ドラッグ・ドロップ用
    @photos = @user.photos
  end
  
  # ドラッグ・ドロップ用
  def sort
    # userの特定
    @user = User.find(params[:id])
    # 特定したuserのphotoを全て取得
    @photos = Photo.where(user_id: @user.id)
    #fromの値から動かしたphotoの特定
    photo = @photos.find_by(position: params[:from])
    #特定したphotoの順番をtoで取得、挿入
    photo.insert_at(params[:to].to_i)
    head :ok
  end

  #ユーザ情報編集ページ
  def edit
    @user = User.find(current_user.id)
  end

  def update
  @user = User.find(params[:id])
  #退会用の記述
   if params[:user][:user_status] == "false" #退会用の記述
     @user.user_status = false
     @user.save
     reset_session #ログアウト
     redirect_to root_path
     
   else
      #会員登録情報の編集用記述
         if @user.update(user_params)
            redirect_to users_path
         else 
          render 'edit'
       end
     end
  end
  
   #ユーザ退会ページ
  def leave
    @user = User.find(current_user.id)
  end

  private

  def user_params
    params.require(:user).permit ([:user_maker, :name, :staff, :introduction, :postal_code, :address, :phone_number, :profile_image, :tag_list, :user_status, :instagram, :facebook, :homepage])
  end

end
