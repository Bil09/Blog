class CategoriesController < ApplicationController
before_action :require_admin, only: [:new, :create]
    def index
        @categories = Category.paginate(page: params[:page], per_page: 5)
    end

    
    def new
        @category = Category.new
    end


    def create
        @category = Category.new(categories_params)
        if @category.save
            flash[:success] = "Successfully created"
            redirect_to categories_path
        else
            render 'new'
        end
    end


    def show
     
    end
 
    private


    def categories_params
        params.require(:category).permit(:name)
    end
     

    def require_admin
        if !logged_in? || (logged_in? && !current_user.admin)
            flash[:danger] = "only admin can permorm that action"
            redirect_to categories_path
        end    
    end
    

    
    
    
end