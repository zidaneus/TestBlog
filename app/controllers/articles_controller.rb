class ArticlesController < ApplicationController

	def home
		if signed_in?
			@comment = current_user.comments.build
			@feed_items = current_user.feed.paginate(page: params[:page])
		end
	end

	def index
		@articles = Article.paginate :page => params[:page], :per_page => 15#Article.paginate(page: params[:page])
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

	private
		def article_params
			params.require(:article).permit(:title, :text)
		end
end
