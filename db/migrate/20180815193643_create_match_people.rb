class CreateMatchPeople < ActiveRecord::Migration[5.2]
  def change
    create_table :match_people do |t|
      t.string :name
      t.string :email
      t.string :okc
      t.string :fb
      t.string :li
      t.integer :age
      t.string :acceptable_range
      t.string :occupation
      t.string :location
      t.references :gender, foreign_key: true
      t.integer :openness
      t.string :identities
      t.text :current_partners
      t.text :situation
      t.text :kids
      t.binary :ask_first
      t.string :keep_dating
      t.binary :only_strong_match
      t.string :num_matches
      t.text :important
      t.text :disappointments
      t.text :date_activities
      t.text :murphyjitsu
      t.text :incompatible
      t.binary :continue_matching
      t.text :anything_else
      t.text :notes
      t.string :image_link
      t.string :seeking_genders

      t.timestamps
    end
  end
end
