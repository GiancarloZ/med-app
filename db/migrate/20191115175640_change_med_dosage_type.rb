class ChangeMedDosageType < ActiveRecord::Migration
  def change
    change_column :meds, :dosage, :float
  end
end
