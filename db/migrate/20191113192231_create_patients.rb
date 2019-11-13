class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :email
      t.string :username
      t.string :password
      t.string :first_name
      t.string :last_name
      t.integer :doctor_id
    end
  end
end
