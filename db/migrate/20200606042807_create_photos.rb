class CreatePhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :photos do |t|
      t.integer :user_id
      t.string :photo_image_id
      t.text :introduction
      t.timestamps
    end
  end
end
