require 'test_helper'

class StatusesControllerTest < ActionController::TestCase

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:statuses)
  end

  test "should get new" do
    login_as :one
    get :new, :user_id => users(:one).to_param
    assert_response :success
  end

  test "should create status" do
    login_as :one
    assert_difference('Status.count') do
      post :create, :user_id => users(:one).to_param, :status => { :body => "test" }
    end

    assert_redirected_to user_status_path(users(:one), assigns(:status))
  end

  test "should show status without user_id" do
    get :show, :id => statuses(:one).to_param
    assert_response :success
  end
  
  test "should show status" do
    get :show, :id => statuses(:one).to_param, :user_id => users(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    login_as :one
    get :edit, :id => statuses(:one).to_param, :user_id => users(:one).to_param
    assert_response :success
  end

  test "should update status" do
    login_as :one
    put :update, :id => statuses(:one).to_param, :user_id => users(:one).to_param, :status => { :body => "new" }
    assert_redirected_to user_status_path(users(:one), assigns(:status))
  end

  test "should destroy status" do
    login_as :one
    assert_difference('Status.count', -1) do
      delete :destroy, :id => statuses(:one).to_param, :user_id => users(:one).to_param
    end

    assert_redirected_to user_statuses_path(users(:one))
  end

  protected
  def login_as(user)
    @request.env["HTTP_AUTHORIZATION"] = "Basic " + Base64::encode64("#{users(user).login}:#{users(user).password}")
  end
end
