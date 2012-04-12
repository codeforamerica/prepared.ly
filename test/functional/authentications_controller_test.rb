require 'test_helper'

class AuthenticationsControllerTest < ActionController::TestCase
  setup do
    @authentication = authentications(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:authentications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create authentication" do
    assert_difference('Authentication.count') do
      post :create, authentication: { create: @authentication.create, destroy: @authentication.destroy, index: @authentication.index, provider: @authentication.provider, uid: @authentication.uid, user_id: @authentication.user_id }
    end

    assert_redirected_to authentication_path(assigns(:authentication))
  end

  test "should show authentication" do
    get :show, id: @authentication
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @authentication
    assert_response :success
  end

  test "should update authentication" do
    put :update, id: @authentication, authentication: { create: @authentication.create, destroy: @authentication.destroy, index: @authentication.index, provider: @authentication.provider, uid: @authentication.uid, user_id: @authentication.user_id }
    assert_redirected_to authentication_path(assigns(:authentication))
  end

  test "should destroy authentication" do
    assert_difference('Authentication.count', -1) do
      delete :destroy, id: @authentication
    end

    assert_redirected_to authentications_path
  end
end
