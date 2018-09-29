require 'test_helper'

class GetUpdateControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get get_update_index_url
    assert_response :success
  end

end
