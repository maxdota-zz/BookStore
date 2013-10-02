require 'test_helper'

class BooksControllerTest < ActionController::TestCase
  setup do
    @book = books(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:books)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create book" do
    assert_difference('Book.count') do
      post :create, book: { author_name: @book.author_name, description: @book.description, photo_url: @book.photo_url, published_date: @book.published_date, publisher_name: @book.publisher_name, title: @book.title, total_rating_count: @book.total_rating_count, total_rating_value: @book.total_rating_value, unit_price: @book.unit_price }
    end

    assert_redirected_to book_path(assigns(:book))
  end

  test "should show book" do
    get :show, id: @book
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @book
    assert_response :success
  end

  test "should update book" do
    put :update, id: @book, book: { author_name: @book.author_name, description: @book.description, photo_url: @book.photo_url, published_date: @book.published_date, publisher_name: @book.publisher_name, title: @book.title, total_rating_count: @book.total_rating_count, total_rating_value: @book.total_rating_value, unit_price: @book.unit_price }
    assert_redirected_to book_path(assigns(:book))
  end

  test "should destroy book" do
    assert_difference('Book.count', -1) do
      delete :destroy, id: @book
    end

    assert_redirected_to books_path
  end
end
