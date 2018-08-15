require 'test_helper'

class MatchPeopleControllerTest < ActionDispatch::IntegrationTest
  setup do
    @match_person = match_people(:one)
  end

  test "should get index" do
    get match_people_url
    assert_response :success
  end

  test "should get new" do
    get new_match_person_url
    assert_response :success
  end

  test "should create match_person" do
    assert_difference('MatchPerson.count') do
      post match_people_url, params: { match_person: { age: @match_person.age, anything_else: @match_person.anything_else, aromantic: @match_person.aromantic, asexual: @match_person.asexual, ask_first: @match_person.ask_first, continue_matching: @match_person.continue_matching, current_partners: @match_person.current_partners, date_activities: @match_person.date_activities, disappointments: @match_person.disappointments, email: @match_person.email, fb: @match_person.fb, gender_id: @match_person.gender_id, important: @match_person.important, incompatible: @match_person.incompatible, keep_dating: @match_person.keep_dating, kids: @match_person.kids, li: @match_person.li, location: @match_person.location, murphyjitsu: @match_person.murphyjitsu, name: @match_person.name, notes: @match_person.notes, num_matches: @match_person.num_matches, occupation: @match_person.occupation, okc: @match_person.okc, only_strong_match: @match_person.only_strong_match, openness: @match_person.openness, range_max: @match_person.range_max, range_min: @match_person.range_min, situation: @match_person.situation } }
    end

    assert_redirected_to match_person_url(MatchPerson.last)
  end

  test "should show match_person" do
    get match_person_url(@match_person)
    assert_response :success
  end

  test "should get edit" do
    get edit_match_person_url(@match_person)
    assert_response :success
  end

  test "should update match_person" do
    patch match_person_url(@match_person), params: { match_person: { age: @match_person.age, anything_else: @match_person.anything_else, aromantic: @match_person.aromantic, asexual: @match_person.asexual, ask_first: @match_person.ask_first, continue_matching: @match_person.continue_matching, current_partners: @match_person.current_partners, date_activities: @match_person.date_activities, disappointments: @match_person.disappointments, email: @match_person.email, fb: @match_person.fb, gender_id: @match_person.gender_id, important: @match_person.important, incompatible: @match_person.incompatible, keep_dating: @match_person.keep_dating, kids: @match_person.kids, li: @match_person.li, location: @match_person.location, murphyjitsu: @match_person.murphyjitsu, name: @match_person.name, notes: @match_person.notes, num_matches: @match_person.num_matches, occupation: @match_person.occupation, okc: @match_person.okc, only_strong_match: @match_person.only_strong_match, openness: @match_person.openness, range_max: @match_person.range_max, range_min: @match_person.range_min, situation: @match_person.situation } }
    assert_redirected_to match_person_url(@match_person)
  end

  test "should destroy match_person" do
    assert_difference('MatchPerson.count', -1) do
      delete match_person_url(@match_person)
    end

    assert_redirected_to match_people_url
  end
end
