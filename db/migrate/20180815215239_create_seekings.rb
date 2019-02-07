class CreateSeekings < ActiveRecord::Migration[5.2]
  def change
    create_table :seekings do |t|
      t.references :gender, foreign_key: true
      t.references :match_person, foreign_key: true

      t.timestamps
    end
  end
end
