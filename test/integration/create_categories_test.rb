require 'test_helper'
class CategoriesTest < ActionDispatch::IntegrationTest
      
   def setup
    @user = User.create(username: "joe", email: "joe@example.com", password: "password", admin: true)
   end
   


    test "get new category form and create new category" do
        sign_in_as(@user,"password")
        get new_category_path
        assert_template 'categories/new'
        assert_difference "Category.count", 1 do
          post categories_path, params: {category: {name: "sports"}}
          follow_redirect!
        end
        assert_template 'categories/index'
        assert_match "sports", response.body
    end

    test "invald category submission should result in a failure" do
        sign_in_as(@user,"password")
        get new_category_path
        assert_template 'categories/new'
        assert_no_difference "Category.count" do
          post categories_path, params: {category: {name: " "}}
        end
        assert_template 'categories/new'
        assert_select 'h2'
    end


end