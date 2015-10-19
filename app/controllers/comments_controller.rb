class CommentsController < ApplicationController
	before_action :signed_in_user, only: [:create, :destroy]
	before_action :correct_user, only: :destroy
	http_basic_authenticate_with name: "dhh", password: "secret", only: :destroy

	def create
		@article = Article.find(params[:article_id])
		@comment = @article.comments.create(comment_params)
		redirect_to article_path(@article)
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
