class CreateCheckIns < ActiveRecord::Migration
  def change
    create_table :check_ins do |t|
      t.integer :host_id
      t.integer :guest_id
      t.date :date_in
      t.date :date_out

      t.timestamps
    end
  end
end
