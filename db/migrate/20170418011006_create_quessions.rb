class CreateQuessions < ActiveRecord::Migration
  def change
    create_table :quessions do |t|
      t.references :lession, index: true, foreign_key: true
      t.string :content

      t.timestamps null: false
    end
  end
end
