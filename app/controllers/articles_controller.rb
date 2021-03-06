class ArticlesController < ApplicationController
before_action :set_article_id, only: [:edit, :show, :update, :destroy]
before_action :require_user, expect: [:index, :show]
before_action :require_same_user, only: [:edit, :update, :destroy]

    def index
      @allarticles = Article.paginate(page: params[:page], per_page: 5)
    end

    def new
        @article = Article.new
    end

    def edit
    end

    def create
        @article = Article.new(article_params)
        @article.user = current_user
        if @article.save
          flash[:success] = "Hey, the article was successfully created"
          redirect_to article_path(@article)
        else
          render 'new'
        end
    end
    def update
      if @article.update(article_params)
        flash[:success] = "Article was successfully updated"
        redirect_to article_path(@article)
      else
        render 'edit'
      end
    end
    def show
    end
    def destroy
      @article.destroy
      flash[:danger] = "The article was successfully deleted"
      redirect_to articles_path
    end
    
    
    private

      def article_params
        params.require(:article).permit(:title, :description, category_ids: [])
      end

      def set_article_id
        @article = Article.find(params[:id])
      end
      

      def require_same_user
        if current_user != @article.user and !current_user.admin?
          flash[:danger] = "You are not the owner of the article"
          redirect_to root_path
        end

        
      end
        
      

end