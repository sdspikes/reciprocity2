class CreateCompatibilities < ActiveRecord::Migration[5.2]
  def change
    create_table :compatibilities do |t|
      t.string :dealbreaker
      t.integer :rating
      t.text :notes
      t.string :introduction_made
      t.references :match_person_1, references: :MatchPerson
      t.references :match_person_2, references: :MatchPerson

      t.timestamps
    end
  end
end
