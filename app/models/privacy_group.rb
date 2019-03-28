class PrivacyGroup < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  has_many :profile_items
  has_many :privacy_group_members

  def create_facebook_group(token)
    @privacy_group = PrivacyGroup.new("Facebook Friends", current_user.id)
    friend_list = Facebook.get_connections(current_user.token, "me", "friends").map {|node| node["id"]}
    # OK so - the UID is actually just already included in the user model - maybe pay attention next time.
    # The next step is considering other approaches - it's been suggested that instead of cramming this into the privacy group model
    # Instead have a method that uses the Facebook data directly to create a list of User models such that you're mostly querying the API when
    # this group is needed - using ActiveRecord subsets was suggested for this but I'm having trouble wrapping my head around them.
    # But I guess the structure is - get the list of facebook IDs, then grab User.all filtered by facebook ID, and somehow this does it all as one query?
    # Still confusing but maybe works
    # Possible performance issues - consider figuring out how to avoid N+1 issues
    # Try grabbing the privacy group joined w/ user table, grab the facebook ids, and then grab the user ids and use a hash or somethin'
  end
end
