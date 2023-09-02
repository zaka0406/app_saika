class AddSelectionToReservations < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :selection, :string
  end
end
