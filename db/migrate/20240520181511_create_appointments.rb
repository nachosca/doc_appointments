class CreateAppointments < ActiveRecord::Migration[7.1]
  def change
    create_table :appointments do |t|
      t.references :doctor, foreign_key: true
      t.references :patient, foreign_key: true, default: nil
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
