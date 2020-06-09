class PhotosController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @photo = Photo.new(photo_params)
    @photo.user_id = current_user.id
    if @photo.save
      #フォロワー全員に通知する
      @followed_users = current_user.followers
      @followed_users.each do |user|
        current_user.create_notification_photo!(user)
      end
    end
    redirect_to user_path(current_user.id)
  end

  def edit
  	@photo = Photo.find(params[:id])
  end

  def update
  	@photo = Photo.find(params[:id])
  	@photo.update(photo_params)
  	redirect_to user_path(current_user.id)
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
