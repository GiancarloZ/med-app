class CreateDoctors < ActiveRecord::Migration
  def change
    create_table :doctors do |t|
      t.string :email
      t.string :username
      t.string :password
      t.string :first_name
      t.string :last_name
    end
  end
end
