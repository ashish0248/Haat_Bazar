class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
    	t.integer :document_id
    	t.string :name
    	t.string :price
    	t.string :number
      t.timestamps
    end
  end
end
