ActiveAdmin.register Contact do
    menu priority: 4, label: "お問い合わせ一覧"
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :email, :message
  #
  # or
  #
  permit_params do
    permitted = [:name, :email, :message]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end

  index do
    selectable_column
    id_column
    column "お名前",:name
    column "メールアドレス",:email
    column "お問い合わせ内容",:message
    actions
  end
  
end
