class Compatibility < ApplicationRecord
  belongs_to :match_person_1, class_name: :MatchPerson
  belongs_to :match_person_2, class_name: :MatchPerson

  validates :match_person_1, :uniqueness => { :scope => :match_person_2 }
  validates :match_person_2, :uniqueness => { :scope => :match_person_1 }

  def get_other_person(match_person)
  	get_other_person_by_id(match_person.id)
  end

  def get_other_person_by_id(match_person_id)
  	if (match_person_1_id == match_person_id)
  		return MatchPerson.find(match_person_2_id)
  	else
  		return MatchPerson.find(match_person_1_id)
    end
  end

end
