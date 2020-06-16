ActiveAdmin.register Photo do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :user_id, :photo_image_id, :introduction, :position
  #
  # or
  #
  permit_params do
    permitted = [:user_id, :photo_image_id, :introduction, :position]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end

  index do
    selectable_column
    id_column
    column "ユーザーID",:user_id
    column "画像",:photo_image_id
    column "紹介文",:introduction
    column "順番",:position
    actions
  end
  
end
