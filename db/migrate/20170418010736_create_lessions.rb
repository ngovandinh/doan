class CreateLessions < ActiveRecord::Migration
  def change
    create_table :lessions do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
