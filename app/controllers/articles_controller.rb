class ArticlesController < ApplicationController
	def index
		render json: "Hello"
	end

	def show
		render json: "Hello from show action"
	end

end