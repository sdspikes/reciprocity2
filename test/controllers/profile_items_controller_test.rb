require 'test_helper'

class ProfileItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @profile_item = profile_items(:one)
  end

  test "should get index" do
    get profile_items_url
    assert_response :success
  end

  test "should get new" do
    get new_profile_item_url
    assert_response :success
  end

  test "should create profile_item" do
    assert_difference('ProfileItem.count') do
      post profile_items_url, params: { profile_item: { data_id: @profile_item.data_id, privacy_group_id: @profile_item.privacy_group_id, profile_item_category: @profile_item.profile_item_category, user_id: @profile_item.user_id } }
    end

    assert_redirected_to profile_item_url(ProfileItem.last)
  end

  test "should show profile_item" do
    get profile_item_url(@profile_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_profile_item_url(@profile_item)
    assert_response :success
  end

  test "should update profile_item" do
    patch profile_item_url(@profile_item), params: { profile_item: { data_id: @profile_item.data_id, privacy_group_id: @profile_item.privacy_group_id, profile_item_category: @profile_item.profile_item_category, user_id: @profile_item.user_id } }
    assert_redirected_to profile_item_url(@profile_item)
  end

  test "should destroy profile_item" do
    assert_difference('ProfileItem.count', -1) do
      delete profile_item_url(@profile_item)
    end

    assert_redirected_to profile_items_url
  end
end
