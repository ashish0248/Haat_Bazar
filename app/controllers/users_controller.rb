class UsersController < ApplicationController
  before_action :authenticate_user!
  # ユーザ情報表示ページ
  def index
    @user = current_user
  end

  #マイページ
  def new
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
    @user = User.find(current_user.id)
    @user.update(user_params)
    redirect_to  users_path
  end
   #ユーザ退会ページ
  def leave
  end

  private

  def user_params
    params.require(:user).permit ([:user_maker, :name, :staff, :introduction, :postal_code, :address, :phone_number, :profile_image, :tag_list])
  end

end
