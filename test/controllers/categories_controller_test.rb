class CategoriesControllerTest < ActionController::TestCase
  def setup
    @category = Category.create(name:"sports")
  end

  test "should get index action" do 
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success

  end

  test "should get show" do
    get(:show, params: {id: @category.id})
    assert_response :success
  end
end