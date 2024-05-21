class CreateDoctors < ActiveRecord::Migration[7.1]
  def change
    create_table :doctors do |t|
      t.string :name
      t.string :specialty
      t.integer :appointment_duration

      t.timestamps
    end
  end
end
