require "application_system_test_case"

class SeekingsTest < ApplicationSystemTestCase
  setup do
    @seeking = seekings(:one)
  end

  test "visiting the index" do
    visit seekings_url
    assert_selector "h1", text: "Seekings"
  end

  test "creating a Seeking" do
    visit seekings_url
    click_on "New Seeking"

    fill_in "Gender", with: @seeking.gender_id
    fill_in "Match Person", with: @seeking.match_person_id
    click_on "Create Seeking"

    assert_text "Seeking was successfully created"
    click_on "Back"
  end

  test "updating a Seeking" do
    visit seekings_url
    click_on "Edit", match: :first

    fill_in "Gender", with: @seeking.gender_id
    fill_in "Match Person", with: @seeking.match_person_id
    click_on "Update Seeking"

    assert_text "Seeking was successfully updated"
    click_on "Back"
  end

  test "destroying a Seeking" do
    visit seekings_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Seeking was successfully destroyed"
  end
end
