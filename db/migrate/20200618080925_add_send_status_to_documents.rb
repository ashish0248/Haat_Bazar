class AddSendStatusToDocuments < ActiveRecord::Migration[5.2]
  def change
    add_column :documents, :send_status, :boolean, default: false, null: false
  end
end
