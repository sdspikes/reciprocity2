class ProfileItem < ApplicationRecord

  PROFILE_ITEM_DATA_TYPES = %w(TextProfileItem ProfileItemResponse)

  belongs_to :user
  belongs_to :privacy_group, optional: true
  belongs_to :profile_item_category
  belongs_to :profile_item_data, polymorphic: true
  accepts_nested_attributes_for :profile_item_data


  def build_profile_item_data(params)
    raise "Unknown profile_item_data_type: #{profile_item_data_type}" unless PROFILE_ITEM_DATA_TYPES.include?(profile_item_data_type)
    self.profile_item_data = profile_item_data_type.constantize.create(params)
  end
end
