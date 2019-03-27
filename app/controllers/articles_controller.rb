class ArticlesController < ApplicationController
	def index
		articles = Article.recent
		render json: articles
	end

	def show
		render json: "Hello from show action"
	end

end