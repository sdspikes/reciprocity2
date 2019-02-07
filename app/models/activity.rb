class Activity < ApplicationRecord
  searchkick
  def check_for(checked_id)
    Check.find_by(activity_id: self.id, checker_id: current_user.id, checked_id: checked_id)
  end
end
