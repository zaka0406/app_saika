class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.date :day,null:false
      t.string :time,null:false
      t.datetime :start_time,null:false
      t.string :name,null:false
      t.string :email,null:false
      t.string :phone_number,null:false

      t.timestamps
    end
  end  
  
end
