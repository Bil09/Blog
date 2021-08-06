class CategoriesController < ApplicationController
before_action :require_admin, only: [:new, :create, :edit, :update]
before_action :require_user, only: [:index, :show]
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
     @category = Category.find(params[:id])
     @category_art = @category.articles.paginate(page: params[:page], per_page: 5)
    end

    def edit
        @category = Category.find(params[:id])
    end

    def update
        @category = Category.find(params[:id])
        if @category.update(categories_params)
            flash[:success] = "Category was successfully updated"
            redirect_to category_path(@category)
        else
            render 'edit'
        end
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