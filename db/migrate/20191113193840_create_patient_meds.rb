class CreatePatientMeds < ActiveRecord::Migration
  def change
    create_table :patient_meds do |t|
      t.integer :patient_id
      t.integer :med_id
    end
  end
end
