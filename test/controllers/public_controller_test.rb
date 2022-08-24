require "test_helper"

class PublicControllerTest < ActionDispatch::IntegrationTest
  test "should get homes" do
    get public_homes_url
    assert_response :success
  end
end
