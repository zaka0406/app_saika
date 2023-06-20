class CreateSaikas < ActiveRecord::Migration[6.1]
  def change
    create_table :saikas do |t|
      t.string :name
      t.string :text
      t.text :image
  
      t.timestamps
    end
  end
end
