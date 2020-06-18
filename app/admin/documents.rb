ActiveAdmin.register Document do
  menu priority: 3, label: "書類一覧"
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :document_status, :maker_id, :receiver_id, :maker_name, :maker_postal_code, :maker_address, :maker_staff, :maker_phone_number, :receiver_name, :receiver_postal_code, :receiver_address, :receiver_staff, :receiver_phone_number, :effective_date, :expiration_date, :receipt_number, :payee, :remark
  #
  # or
  #
  permit_params do
    permitted = [:document_status, :maker_id, :receiver_id, :maker_name, :maker_postal_code, :maker_address, :maker_staff, :maker_phone_number, :receiver_name, :receiver_postal_code, :receiver_address, :receiver_staff, :receiver_phone_number, :effective_date, :expiration_date, :receipt_number, :payee, :remark]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end

  index do
    selectable_column
    id_column
    column "書類情報",:document_status
    column "製作者ID",:maker_id
    column "宛先ID",:receiver_id
    column "送り元名",:maker_name
    column "送り元郵便番号",:maker_postal_code
    column "送り元電話番号",:maker_address
    column "送り元担当者",:maker_staff
    column "送り元電話番号",:maker_phone_number

    column "送り先名",:receiver_name
    column "送り先郵便番号",:receiver_postal_code
    column "送り先電話番号",:receiver_address
    column "送り先担当者",:receiver_staff
    column "送り先電話番号",:receiver_phone_number

    column "発行日",:effective_date
    column "期限日",:expiration_date
    column "書類番号",:receipt_number
    column "振込先",:payee
    column "備考",:remark
    actions
  end
  
end
