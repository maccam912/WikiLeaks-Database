require 'test_helper'

class CablesControllerTest < ActionController::TestCase
  setup do
    @cable = cables(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cables)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cable" do
    assert_difference('Cable.count') do
      post :create, :cable => @cable.attributes
    end

    assert_redirected_to cable_path(assigns(:cable))
  end

  test "should show cable" do
    get :show, :id => @cable.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @cable.to_param
    assert_response :success
  end

  test "should update cable" do
    put :update, :id => @cable.to_param, :cable => @cable.attributes
    assert_redirected_to cable_path(assigns(:cable))
  end

  test "should destroy cable" do
    assert_difference('Cable.count', -1) do
      delete :destroy, :id => @cable.to_param
    end

    assert_redirected_to cables_path
  end
end
