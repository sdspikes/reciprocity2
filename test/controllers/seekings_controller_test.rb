require 'test_helper'

class SeekingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @seeking = seekings(:one)
  end

  test "should get index" do
    get seekings_url
    assert_response :success
  end

  test "should get new" do
    get new_seeking_url
    assert_response :success
  end

  test "should create seeking" do
    assert_difference('Seeking.count') do
      post seekings_url, params: { seeking: { gender_id: @seeking.gender_id, match_person_id: @seeking.match_person_id } }
    end

    assert_redirected_to seeking_url(Seeking.last)
  end

  test "should show seeking" do
    get seeking_url(@seeking)
    assert_response :success
  end

  test "should get edit" do
    get edit_seeking_url(@seeking)
    assert_response :success
  end

  test "should update seeking" do
    patch seeking_url(@seeking), params: { seeking: { gender_id: @seeking.gender_id, match_person_id: @seeking.match_person_id } }
    assert_redirected_to seeking_url(@seeking)
  end

  test "should destroy seeking" do
    assert_difference('Seeking.count', -1) do
      delete seeking_url(@seeking)
    end

    assert_redirected_to seekings_url
  end
end
