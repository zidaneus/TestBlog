class ArticlesController < ApplicationController

	def home
		if signed_in?
			@comment = current_user.comments.build
			#@feed_items = current_user.feed.paginate(page: params[:page])
		end
	end

	def index
		@title = "Список статей"
		@articles = Article.paginate :page => params[:page], :per_page => 15
		#@article = Article.new
		#@user = User.find_by(id: params[:user_id])
	end

	def show
		@article = Article.find(params[:id])
	end

	def new
		@article = Article.new
	end

	def edit
		@article = Article.find(params[:id])
	end

	def create
		@article = Article.new(article_params)
		@article.user = current_user
		if @article.save
			redirect_to @article
		else
			render 'new'
		end
	end

	def update
		@article = Article.find(params[:id])
		if @article.update(article_params)
			redirect_to @article
		else
			render 'edit'
		end
	end

	def destroy
		@article = Article.find(params[:id])
		@article.destroy

		redirect_to articles_path
	end

	def search
		@articles = (Article.where("title LIKE '%"+params[:search]+"%' OR text LIKE '%"+params[:search]+"%'")).paginate :page => params[:page], :per_page => 15
		@title = "Результаты поиска по фразе '"+params[:search]+"'"
		render 'index'
	end

	private
		def article_params
			params.require(:article).permit(:title, :text)
		end
end
