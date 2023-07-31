class AddColumnToSaikas < ActiveRecord::Migration[6.1]
  def change
    add_column :saikas, :day, :date
    add_column :saikas, :time, :string
    add_column :saikas, :start_time, :datetime
  end
end
