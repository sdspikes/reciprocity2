# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Compatibility.destroy_all
# Seeking.destroy_all
# MatchPerson.destroy_all
# Gender.destroy_all

Compatibility.all.each do |c|
	c.dealbreaker = false
	c.save
end

# require 'csv'

# csv_text = File.read(Rails.root.join('db', 'seeds', 'match_people.csv'))
# csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')



# field_to_header = {
# 	email: "Email Address",
# 	name: "Name",
# 	okc: "Ok Cupid Profile Link (optional)",
# 	fb: "Facebook Profile Link (optional)",
# 	li: "LinkedIn Profile Link (optional)",
# 	age: "Age",
# 	occupation: "Occupation (or subject of study)",
# 	location: "Where are you located, geographically?",
# 	openness: "What's you preferred relationship style, in terms of openness?",
# 	current_partners: "If you feel comfortable, can you tell us the names of your current partners, and how committed you are to those relationships? ",
# 	situation: "Which of these situations describes you best?",
# 	kids: "What do you think about children?",
# 	ask_first: "Suppose we find a match for you (or several). Do you want us to ask you before making an introduction, or would you prefer we inform both parties right away?",
# 	keep_dating: "I want to keep dating the people I'm currently dating, and any additional partners MUST be supportive of this.",
# 	only_strong_match: "Which of these two is more true for you?",
# 	num_matches: "How many matches do you want us to make?",
# 	important: "What are the 3 most important things you're looking for in a partner? ",
# 	disappointments: "Can you briefly tell us the top 3 disappointments you've had in previous dates or relationships?",
# 	date_activities: "You're going on a date in a couple of weeks! What are 3 things you would be genuinely delighted to do with your partner? ",
# 	murphyjitsu: "Suppose we end up making a match for you, and it ends up being in the realm of ""bad/solidly mediocre"". Why would this be? ",
# 	incompatible: "If there is anyone who you know you are incompatible with, list them here.",
# 	continue_matching: "Would you want the matchmakers to continue looking out for matches for you after the reunion? ",
# 	anything_else: "Is there anything else we should know? ",
# 	notes: "Potential Matches/Notes",
# 	image_link: "Please upload a picture of yourself",
# 	acceptable_range: "What age range is acceptable to you, in your partners?",
# 	identities: "Are any of the following true for you?",
# 	seeking_genders: "Looking for partners who are..."
# }


# def find_or_add_gender(gender)
# 	db_gender = Gender.where(name: gender).first
# 	if (!db_gender) 
# 		p gender
# 		db_gender = Gender.create(name: gender)
# 		p db_gender
# 	end
# 	db_gender
# end

# preset_genders = ['Cis-identifying male', 'Cis-identifying female', 'Trans-identifying male', 'Trans-identifying female', 'Non-binary']

# match_people = csv.each do |row|
# 	row_hash = row.to_h
# 	person_hash = {}
# 	field_to_header.each {|field, header| person_hash[field] = row_hash[header] }

# 	person_hash[:gender] = find_or_add_gender(row_hash["I am..."])
# 	match_person = MatchPerson.create(person_hash)
# 	row_hash["Looking for partners who are..."].split(', ').each do |gender|
# 		Seeking.create(match_person: match_person, gender: find_or_add_gender(gender))
# 	end
# 	MatchPerson.all.each do |matched_person|
# 		if (match_person != matched_person) 
# 			if !preset_genders.include?(match_person.gender) || !preset_genders.include?(matched_person) ||
# 				(Seeking.where(match_person: match_person, gender: matched_person.gender).size > 0 &&
# 				Seeking.where(match_person: matched_person, gender: match_person.gender).size > 0 &&
# 				Compatibility.where(match_person_1: matched_person, match_person_2: match_person).size == 0)
# 				# p "adding!"
# 				Compatibility.create(match_person_1: match_person, match_person_2: matched_person)
# 			end
# 		end
# 	end
# end


# MatchPerson.all.each do |person_a|
# 	MatchPerson.all.each do |person_b|
# 		if (person_b != person_a) 
# 			if ((!preset_genders.include?(person_b.gender) || !preset_genders.include?(person_a)) &&
# 				(Compatibility.where(match_person_1: person_a, match_person_2: person_b).size == 0 &&
# 				Compatibility.where(match_person_1: person_b, match_person_2: person_a).size == 0))
# 				# p "adding!"
# 				Compatibility.create(match_person_1: person_b, match_person_2: person_a)
# 			end
# 		end
# 	end
# end

