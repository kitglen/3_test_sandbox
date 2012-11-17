require 'test_helper'

class Api::V1::TestsControllerTest < ActionController::TestCase
  setup do
    @test = V1::Test.create({:name=>"hoordjxvchoi"}, as: :"System Admin")
  end

  test "should get index of tests" do
    get :index, format: :json
    
    assert_response :success
    assert_not_nil assigns(:tests)
    
  end

  test "should get new test" do
    get :new, format: :json
    assert_response :success
  end

  test "should create test" do
    
    assert_difference('V1::Test.count') do
      post :create, test: {:name=>"nismyjlsrxna"}, format: :json
    end
    assert_response :success
    
  end

  test "should show test" do
    get :show, id: @test, format: :json
    
    assert_response :success
    
  end

  test "should update test" do
    put :update, id: @test, test: {:name=>"ucpnnczifowj"}, format: :json
    
    assert_response :success
    
  end

  test "should destroy test" do
    
    assert_difference('V1::Test.count', -1) do
      delete :destroy, id: @test, format: :json
    end
    assert_response :success
    
  end
end
