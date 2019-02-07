require "application_system_test_case"

class MatchPeopleTest < ApplicationSystemTestCase
  setup do
    @match_person = match_people(:one)
  end

  test "visiting the index" do
    visit match_people_url
    assert_selector "h1", text: "Match People"
  end

  test "creating a Match person" do
    visit match_people_url
    click_on "New Match Person"

    fill_in "Age", with: @match_person.age
    fill_in "Anything Else", with: @match_person.anything_else
    fill_in "Aromantic", with: @match_person.aromantic
    fill_in "Asexual", with: @match_person.asexual
    fill_in "Ask First", with: @match_person.ask_first
    fill_in "Continue Matching", with: @match_person.continue_matching
    fill_in "Current Partners", with: @match_person.current_partners
    fill_in "Date Activities", with: @match_person.date_activities
    fill_in "Disappointments", with: @match_person.disappointments
    fill_in "Email", with: @match_person.email
    fill_in "Fb", with: @match_person.fb
    fill_in "Gender", with: @match_person.gender_id
    fill_in "Important", with: @match_person.important
    fill_in "Incompatible", with: @match_person.incompatible
    fill_in "Keep Dating", with: @match_person.keep_dating
    fill_in "Kids", with: @match_person.kids
    fill_in "Li", with: @match_person.li
    fill_in "Location", with: @match_person.location
    fill_in "Murphyjitsu", with: @match_person.murphyjitsu
    fill_in "Name", with: @match_person.name
    fill_in "Notes", with: @match_person.notes
    fill_in "Num Matches", with: @match_person.num_matches
    fill_in "Occupation", with: @match_person.occupation
    fill_in "Okc", with: @match_person.okc
    fill_in "Only Strong Match", with: @match_person.only_strong_match
    fill_in "Openness", with: @match_person.openness
    fill_in "Range Max", with: @match_person.range_max
    fill_in "Range Min", with: @match_person.range_min
    fill_in "Situation", with: @match_person.situation
    click_on "Create Match person"

    assert_text "Match person was successfully created"
    click_on "Back"
  end

  test "updating a Match person" do
    visit match_people_url
    click_on "Edit", match: :first

    fill_in "Age", with: @match_person.age
    fill_in "Anything Else", with: @match_person.anything_else
    fill_in "Aromantic", with: @match_person.aromantic
    fill_in "Asexual", with: @match_person.asexual
    fill_in "Ask First", with: @match_person.ask_first
    fill_in "Continue Matching", with: @match_person.continue_matching
    fill_in "Current Partners", with: @match_person.current_partners
    fill_in "Date Activities", with: @match_person.date_activities
    fill_in "Disappointments", with: @match_person.disappointments
    fill_in "Email", with: @match_person.email
    fill_in "Fb", with: @match_person.fb
    fill_in "Gender", with: @match_person.gender_id
    fill_in "Important", with: @match_person.important
    fill_in "Incompatible", with: @match_person.incompatible
    fill_in "Keep Dating", with: @match_person.keep_dating
    fill_in "Kids", with: @match_person.kids
    fill_in "Li", with: @match_person.li
    fill_in "Location", with: @match_person.location
    fill_in "Murphyjitsu", with: @match_person.murphyjitsu
    fill_in "Name", with: @match_person.name
    fill_in "Notes", with: @match_person.notes
    fill_in "Num Matches", with: @match_person.num_matches
    fill_in "Occupation", with: @match_person.occupation
    fill_in "Okc", with: @match_person.okc
    fill_in "Only Strong Match", with: @match_person.only_strong_match
    fill_in "Openness", with: @match_person.openness
    fill_in "Range Max", with: @match_person.range_max
    fill_in "Range Min", with: @match_person.range_min
    fill_in "Situation", with: @match_person.situation
    click_on "Update Match person"

    assert_text "Match person was successfully updated"
    click_on "Back"
  end

  test "destroying a Match person" do
    visit match_people_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Match person was successfully destroyed"
  end
end
