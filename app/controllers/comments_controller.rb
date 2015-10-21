class CommentsController < ApplicationController
	before_action :signed_in_user, only: [:create, :destroy]
	before_action :correct_user, only: [:destroy]
 
	def new
	end

	def create
		# @comment = Comment.create[comment_params]
  #   	@comment.article = Article.find(params[:article_id])
  #   	@comment.user = current_user

		@article = Article.find(params[:article_id])
		# @user = current_user

		@comment = @article.comments.create(comment_params)
		@comment.user = current_user
		
		if @comment.save
			flash[:success] = "Комментарий добавлен!"
		end
		redirect_to article_path(@article)		
	end

	def show
		@comment = Comment.find(params[:id])
	end

	# def edit
	# 	@comment = Comment.find(params[:id])
	# end

	def update
		@comment = Comment.find(params[:id])
		@comment.update_attributes(comment_params)
		# if @comment.update_attributes(comment_params)
		# 	flash[:success] = "Комментарий обновлен!"
		# 	redirect_to @comment
		# else
		# 	render 'edit'
		# end
	end

	def destroy
		@article = Article.find(params[:article_id])
		@comment = @article.comments.find(params[:id])
		if @comment.destroy
			flash[:success] = "Комментарий удален!"
			redirect_to article_path(@article)
		end
	#	redirect_to root_url
	end

	private
		def comment_params
			params.require(:comment).permit(:user_id, :text)
		end

		def correct_user
			@comment = current_user.comments.find_by(id: params[:id])
			redirect_to root_url if @comment.nil?
		end
end
