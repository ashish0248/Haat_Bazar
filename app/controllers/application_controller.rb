class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
	before_action :reject_user, only: [:create]


  protected

  #ログインに必要
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_maker, :name, :staff, :introduction, :postal_code, :address, :phone_number, :profile_image, :tag_list, :instagram, :facebook, :homepage])
  end

  #退会済みユーザーがログインできなくする
  def reject_user
  end
  
end
