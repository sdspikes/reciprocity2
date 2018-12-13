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
	ProfileItem.destroy_all
	ProfileItemCategory.destroy_all
	PrivacyGroupMember.destroy_all
	PrivacyGroup.destroy_all
end

destroy_all

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

