class RemoveColumnsFromSaikas < ActiveRecord::Migration[6.1]
  def change
    remove_column :saikas, :name, :string
    remove_column :saikas, :text, :string
    remove_column :saikas, :image, :text
  end
end
