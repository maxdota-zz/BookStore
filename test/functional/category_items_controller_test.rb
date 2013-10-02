require 'test_helper'

class CategoryItemsControllerTest < ActionController::TestCase
  setup do
    @category_item = category_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:category_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create category_item" do
    assert_difference('CategoryItem.count') do
      post :create, category_item: { book_id: @category_item.book_id, category_id: @category_item.category_id }
    end

    assert_redirected_to category_item_path(assigns(:category_item))
  end

  test "should show category_item" do
    get :show, id: @category_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @category_item
    assert_response :success
  end

  test "should update category_item" do
    put :update, id: @category_item, category_item: { book_id: @category_item.book_id, category_id: @category_item.category_id }
    assert_redirected_to category_item_path(assigns(:category_item))
  end

  test "should destroy category_item" do
    assert_difference('CategoryItem.count', -1) do
      delete :destroy, id: @category_item
    end

    assert_redirected_to category_items_path
  end
end
