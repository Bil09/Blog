class ArticlesController < ApplicationController
before_action :set_article_id, only: [:edit, :show, :update, :destroy]

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
        @article.user = User.first
        if @article.save
          flash[:notice] = "Hey, the article was successfully created"
          redirect_to article_path(@article)
        else
          render 'new'
        end
    end
    def update
      if @article.update(article_params)
        flash[:notice] = "Article was successfully updated"
        redirect_to article_path(@article)
      else
        render 'edit'
      end
    end
    def show
    end
    def destroy
      @article.destroy
      flash[:notice] = "The article was successfully deleted"
      redirect_to articles_path
    end
    
    
    private

      def article_params
        params.require(:article).permit(:title, :description)
      end

      def set_article_id
        @article = Article.find(params[:id])
      end
      

end