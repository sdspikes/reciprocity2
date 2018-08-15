class MatchPerson < ApplicationRecord
  belongs_to :gender

  has_many :outgoing_compatibilities, foreign_key: :match_person_1_id, class_name: 'Compatibility'
  has_many :potential_matches, through: :outgoing_compatibilities, source: :match_person_1


  has_many :incoming_compatibilities, foreign_key: :match_person_2_id, class_name: 'Compatibility'
  # has_many :potential_matches, through: :outgoing_compatibilities, source: :match_person_2
end
