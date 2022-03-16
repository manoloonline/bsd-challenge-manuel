require "test_helper"

class TwitchSearchControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get twitch_search_search_url
    assert_response :success
  end
end
