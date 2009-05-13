require 'test_helper'

class FavsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:favs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fav" do
    assert_difference('Fav.count') do
      post :create, :fav => { }
    end

    assert_redirected_to fav_path(assigns(:fav))
  end

  test "should show fav" do
    get :show, :id => favs(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => favs(:one).id
    assert_response :success
  end

  test "should update fav" do
    put :update, :id => favs(:one).id, :fav => { }
    assert_redirected_to fav_path(assigns(:fav))
  end

  test "should destroy fav" do
    assert_difference('Fav.count', -1) do
      delete :destroy, :id => favs(:one).id
    end

    assert_redirected_to favs_path
  end
end
