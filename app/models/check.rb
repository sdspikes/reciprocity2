class Check < ApplicationRecord
  belongs_to :activity

  belongs_to :checker, class_name: "User"
  belongs_to :checked, class_name: "User"
  validates :checker, uniqueness: { scope: [:checked, :activity] }
end
