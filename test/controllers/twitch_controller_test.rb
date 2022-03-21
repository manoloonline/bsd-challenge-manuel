require "test_helper"

class TwitchControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should not get search without login " do
    get twitch_search_url
    assert_response :redirect
  end

  test "should get search logged " do
    sign_in users(:regular)
    get twitch_search_url
    
    assert_response :success
  end

  test "should post search logged " do
    sign_in users(:regular)
    post twitch_search_url, params: { search_string: 'example' }

    assert_response :success
    assert_select 'div.twitcher_card', { :count => 20 }
  end
end

