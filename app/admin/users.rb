ActiveAdmin.register User do

  menu priority: 1, label: "ユーザー"
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :user_maker, :name, :staff, :introduction, :postal_code, :address, :phone_number, :profile_image_id, :user_status, :tag_list
  #
  # or
  #
  permit_params do
    permitted = [:email, :encrypted_password, :user_maker, :name, :staff, :introduction, :postal_code, :address, :phone_number, :profile_image_id, :user_status, :tag_list]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end

  index do
    selectable_column
    id_column
    column "メール",:email
    column "作り手？",:user_maker
    column "名前",:name
    column "担当者名",:staff
    column "自己紹介文",:introduction
    column "郵便番号",:postal_code
    column "住所",:address
    column "電話番号",:phone_number
    column "プロフィール画像",:profile_image_id
    column "有効会員？",:user_status
    actions
  end
  
end
