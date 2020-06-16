class RemovePostageFromDocuments < ActiveRecord::Migration[5.2]
  def change
    remove_column :documents, :postage, :string
  end
end
