require "test_helper"

class My::LeaguesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get my_leagues_index_url
    assert_response :success
  end

  test "should get show" do
    get my_leagues_show_url
    assert_response :success
  end

  test "should get new" do
    get my_leagues_new_url
    assert_response :success
  end

  test "should get create" do
    get my_leagues_create_url
    assert_response :success
  end
end
