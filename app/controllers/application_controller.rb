class ApplicationController < ActionController::Base
before_action :configure_permitted_parameters, if: :devise_controller?


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_maker, :name, :staff, :introduction, :postal_code, :address, :phone_number, :profile_image, :tag_list])
  end
end
