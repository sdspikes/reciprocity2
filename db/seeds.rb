# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
require 'faker'

def destroy_all
	# Compatibility.destroy_all
	# Seeking.destroy_all
	# MatchPerson.destroy_all
	# Gender.destroy_all
	Check.destroy_all
	PrivacyGroupMember.destroy_all
	PrivacyGroup.destroy_all
end

# destroy_all

def reset_users
	User.destroy_all
	100.times {
		u = User.new(name: Faker::Name.name, email: Faker::Internet.email)
		u.password = "Password1"
		u.save
	}
end


def reset_activities
	Activity.destroy_all
	Activity.create([
		{title: 'chat online', description: 'get to know each other online'},
		{title: 'hang out', description: 'hang out in person'},
		{title: 'date', description: 'go out on a date in person'},
	])
end

def create_profile_item_categories
	ProfileItem.destroy_all
	# ProfileItemCategory.destroy_all
	ProfileItemCategory.create(title: "gender", description: "the gender the user identifies as", item_type: "multi")
	ProfileItemCategory.create(title: "bio", description: "short description", item_type: "text")
	ProfileItemCategory.create(title: "looking for", description: "what genders you are open to dating", item_type: "text")
	ProfileItemCategory.create(title: "want kids", description: "whether you are interested in having kids", item_type: "multi")
end


def create_genders
	gender_options = [ProfileItemResponse.create(value: 'female', profile_item_category: ProfileItemCategory.first), ProfileItemResponse.create(value: 'male', profile_item_category: ProfileItemCategory.first), ProfileItemResponse.create(value: 'non-binary', profile_item_category: ProfileItemCategory.first)]

	User.all.each do |u|
		pi = ProfileItem.create(user: u, profile_item_category: ProfileItemCategory.first, profile_item_data: gender_options.sample)
	end
end

def create_bios
	User.all.each do |u|
		pi = ProfileItem.create(user: u, profile_item_category: ProfileItemCategory.all[1], profile_item_data: TextProfileItem.create(value: Faker::Lorem.words(50).join(" ")))
	end
end
destroy_all
reset_users
reset_activities
create_profile_item_categories
create_genders
create_bios
