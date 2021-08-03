require 'test_helper'
class CategoriesControllerTest < ActionDispatch::IntegrationTest


    def setup
        @category = Category.create(name: "sports")
    end
    

    test "shold get categories index" do
        get categories_path
        assert_response :success
    end



    test "shold get categories new" do
        get new_category_path
        assert_response :success
    end



    test "should get category show page" do
        get category_path(@category)
        assert_response :success
    end
    


end