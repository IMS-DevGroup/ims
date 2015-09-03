require 'test_helper'

class BarcodeTestsControllerTest < ActionController::TestCase
  setup do
    @barcode_test = barcode_tests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:barcode_tests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create barcode_test" do
    assert_difference('BarcodeTest.count') do
      post :create, barcode_test: { device_id: @barcode_test.device_id }
    end

    assert_redirected_to barcode_test_path(assigns(:barcode_test))
  end

  test "should show barcode_test" do
    get :show, id: @barcode_test
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @barcode_test
    assert_response :success
  end

  test "should update barcode_test" do
    patch :update, id: @barcode_test, barcode_test: { device_id: @barcode_test.device_id }
    assert_redirected_to barcode_test_path(assigns(:barcode_test))
  end

  test "should destroy barcode_test" do
    assert_difference('BarcodeTest.count', -1) do
      delete :destroy, id: @barcode_test
    end

    assert_redirected_to barcode_tests_path
  end
end
