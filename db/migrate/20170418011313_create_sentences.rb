class CreateSentences < ActiveRecord::Migration
  def change
    create_table :sentences do |t|
      t.references :test, index: true, foreign_key: true
      t.references :quession, index: true, foreign_key: true
      t.references :answer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
