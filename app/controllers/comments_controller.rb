class CommentsController < ApplicationController
	before_action :signed_in_user, only: [:create, :destroy]
	before_action :correct_user, only: :destroy

	def create
		# @comment = Comment.new params[:comment]
  #   	@comment.article = @article ||= Article.find( params[:article_id] )
  #   	@comment.user = @user

		@article = Article.find(params[:article_id])

		@comment = @article.comments.create(comment_params)
		@user = current_user
		if @comment.save
			flash[:success] = "Комментарий добавлен!"
			redirect_to article_path(@article)
		end
	end

	def destroy
	#	@article = Article.find(params[:article_id])
	#	@comment = @article.comments.find(params[:id])
		@comment.destroy
	#	redirect_to article_path(@article)
		redirect_to root_url
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
