class AddMinAndMaxAgeToMatchPeople < ActiveRecord::Migration[5.2]
  def up
  	add_column :match_people, :max_age, :integer, default: 100
  	add_column :match_people, :min_age, :integer, default: 18

  	MatchPerson.all.each do |mp|
  		expr = /(\d+)\D*(\d*)/
  		ages = mp.acceptable_range.scan(expr)
  		if !ages[0]
  			next
  		end
		ages = ages[0]
  		if ages[0] && ages[0].to_i
  			mp.min_age = ages[0].to_i
  		end
  		if ages[1] && ages[1] != "" && ages[1].to_i
  			mp.max_age = ages[1].to_i
  		end
  	end
  end

  def down
  	remove_column :match_people, :max_age
  	remove_column :match_people, :min_age
  end
end
