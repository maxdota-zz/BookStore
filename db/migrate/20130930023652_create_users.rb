class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email_address
      t.string :password_digest
      t.string :phone
      t.string :full_name
      t.date :birthday
      t.date :account_creation_date

      t.timestamps
    end
  end
end
