class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.integer :user_id
      t.references :follow, foreign_key: { to_table: :users }
      t.timestamps

      t.index [:user_id, :follow_id], unique: true
    end
  end
end
