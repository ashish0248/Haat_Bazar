class PhotosController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @photo_new = Photo.new(photo_params)
    @photo_new.user_id = current_user.id
    if @photo_new.save
      #フォロワー全員に通知する
      @followed_users = current_user.followers
      @followed_users.each do |user|
        current_user.create_notification_photo!(user)

      redirect_to user_path(current_user.id)
      end
    else
    @user = User.find(current_user.id)
    @photos = Photo.where(user_id: @user.id)
    # ドラッグ・ドロップ用
    @photos = @user.photos

    render 'users/show'
    end
  end

  def edit
  	@photo = Photo.find(params[:id])
  end

  def update
  	@photo = Photo.find(params[:id])
  	if @photo.update(photo_params)
      redirect_to user_path(current_user.id)
    else
      render 'edit'
    end
  end
  	
  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    redirect_to user_path(current_user.id)
  end

  private

  def photo_params
    params.require(:photo).permit(:photo_image, :introduction)
  end


end
