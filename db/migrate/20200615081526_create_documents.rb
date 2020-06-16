class CreateDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :documents do |t|
    	t.string :document_status
    	t.integer :maker_id
    	t.integer :receiver_id
    	t.string :maker_name
    	t.string :maker_postal_code
    	t.string :maker_address
    	t.string :maker_staff
    	t.string :maker_phone_number
    	t.string :receiver_name
    	t.string :receiver_postal_code
    	t.string :receiver_address
    	t.string :receiver_staff
    	t.string :receiver_phone_number
    	t.string :effective_date
    	t.string :expiration_date
    	t.string :postage
    	t.string :receipt_number
    	t.string :payee
    	t.text :remark
      t.timestamps
    end
  end
end