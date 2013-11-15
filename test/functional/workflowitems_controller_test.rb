require 'test_helper'

class WorkflowitemsControllerTest < ActionController::TestCase
  test "should get allworkflowitems" do
    get :allworkflowitems
    assert_response :success
  end

end
