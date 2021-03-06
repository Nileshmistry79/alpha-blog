require "test_helper"

class CategoriesControllerTest < ActionController::TestCase
  
  def setup
    @category = Category.create(name: "sport")
    @user = User.create(username: "joohn", email: "a@test.com", password: "password", admin: true)
  end  

  test "Should get category index"  do
      
      get :index
      assert_response :success
    
  end
  
  test "should get name " do
       session[:user_id]=@user.id
       get :new
      assert_response :success
  end
  
  test "should get show" do
     get(:show, {'id' => @category.id})
      assert_response :success
  end  
  
    test  "should redirect to page when admin is not logged in" do
      assert_no_difference 'Category.count' do
        post :create, category: { name: "sports"}
      end 
      assert_redirected_to categories_path
  end  


  
  
end
