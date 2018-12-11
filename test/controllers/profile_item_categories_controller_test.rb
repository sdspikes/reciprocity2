require 'test_helper'

class ProfileItemCategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @profile_item_category = profile_item_categories(:one)
  end

  test "should get index" do
    get profile_item_categories_url
    assert_response :success
  end

  test "should get new" do
    get new_profile_item_category_url
    assert_response :success
  end

  test "should create profile_item_category" do
    assert_difference('ProfileItemCategory.count') do
      post profile_item_categories_url, params: { profile_item_category: { description: @profile_item_category.description, title: @profile_item_category.title } }
    end

    assert_redirected_to profile_item_category_url(ProfileItemCategory.last)
  end

  test "should show profile_item_category" do
    get profile_item_category_url(@profile_item_category)
    assert_response :success
  end

  test "should get edit" do
    get edit_profile_item_category_url(@profile_item_category)
    assert_response :success
  end

  test "should update profile_item_category" do
    patch profile_item_category_url(@profile_item_category), params: { profile_item_category: { description: @profile_item_category.description, title: @profile_item_category.title } }
    assert_redirected_to profile_item_category_url(@profile_item_category)
  end

  test "should destroy profile_item_category" do
    assert_difference('ProfileItemCategory.count', -1) do
      delete profile_item_category_url(@profile_item_category)
    end

    assert_redirected_to profile_item_categories_url
  end
end
