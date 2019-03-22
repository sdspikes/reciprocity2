class PrivacyGroup < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  has_many :profile_items
  has_many :privacy_group_members

  def create_facebook_group(token)
    @privacy_group = PrivacyGroup.new("Facebook Friends", current_user.id)
    friend_list = Facebook.get_connections(current_user.token, "me", "friends").map {|node| node["id"]}
    #Make a migration for the User model to have a "facebook_id" row, and then have this iterate into creating Privacy Group Members via finding
    # User ids (in fact, probably just use the Facebook ID to grab the User model in the friend_list population, and then use that)
    # Possible performance issues - consider figuring out how to avoid N+1 issues
    # Try grabbing the privacy group joined w/ user table, grab the facebook ids, and then grab the user ids and use a hash or somethin'
  end
end
