class MatchPerson < ApplicationRecord
  belongs_to :gender

  has_many :outgoing_compatibilities, foreign_key: :match_person_1_id, class_name: 'Compatibility'
  has_many :potential_matches, through: :outgoing_compatibilities, source: :match_person_1


  has_many :incoming_compatibilities, foreign_key: :match_person_2_id, class_name: 'Compatibility'
  # has_many :potential_matches, through: :outgoing_compatibilities, source: :match_person_2

  before_create :set_age_range

  def set_age_range
    expr = /(\d+)\D*(\d*)/
    ages = acceptable_range.scan(expr)
    ages = ages[0]
    if !ages || ages.size != 2 then return end
    if ages[0] && ages[0].to_i
      self.min_age = ages[0].to_i
    end
    if ages[1] && ages[1] != "" && ages[1].to_i
      self.max_age = ages[1].to_i
    end
  end

end
