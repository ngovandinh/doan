class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :avatar
      t.string :address
      t.string :phone
      t.string :password_digest
      t.string :is_admin

      t.timestamps null: false
    end
  end
end
