class ChangeColumnPassword < ActiveRecord::Migration
  def change
    rename_column :doctors, :password, :password_digest
    rename_column :patients, :password, :password_digest
  end
end
